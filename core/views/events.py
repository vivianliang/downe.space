from django.core.exceptions import ValidationError
from django.core.paginator import EmptyPage, Paginator
from django.db import transaction
from rest_framework.response import Response
from rest_framework.views import APIView

from ..forms import EventForm, PictureForm
from ..location_utils import mi_to_km
from ..models import Coords, Event
from ..serializers import EventSerializer


class EventsView(APIView):

  def get(self, request, *args, **kwargs):
    '''Get events.'''
    events = Event.objects.all()

    # location range filter
    lat, lon, loc_range = [request.GET.get(key) for key in ['lat', 'lon', 'range']]
    if lat and lon and loc_range:
      # coord filter expects kilometers
      loc_range = mi_to_km(float(loc_range))
      coord_ids = Coords.objects.nearby(lat, lon, loc_range).values_list('id', flat=True)
      events    = events.filter(coords__in=coord_ids)

    # 9 events per page
    paginator = Paginator(events, 9)

    page = int(request.GET.get('page', 1))
    try:
      events = paginator.page(page)
    except EmptyPage:
      events = paginator.page(paginator.num_pages)

    data = {
      'events'     : EventSerializer(events, many=True).data,
      'total_pages': paginator.num_pages,
      'page'       : page,
      'more'       : page < paginator.num_pages
    }
    return Response(data)

  def post(self, request, *args, **kwargs):
    '''Create a new event.'''
    data            = request.data
    data['contact'] = request.user.id
    event_form      = EventForm(data, request.FILES)

    if not event_form.is_valid():
      raise ValidationError(event_form.errors)

    with transaction.atomic():
      event = Event.objects.create(**event_form.cleaned_data)

    return Response(EventSerializer(event).data)

  def put(self, request, *args, **kwargs):
    '''Add an event picture.'''
    print request.data
    data            = request.data
    picture_form      = PictureForm(data, request.FILES)
    print picture_form

    if not picture_form.is_valid():
      raise ValidationError(picture_form.errors)

    with transaction.atomic():
      event = Event.objects.first()
      # event = Event.objects.create(**event_form.cleaned_data)

    return Response(EventSerializer(event).data)
