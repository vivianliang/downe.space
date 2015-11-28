from django.core.paginator import EmptyPage, Paginator
from django.http import JsonResponse
from rest_framework.views import APIView

from ..location_utils import mi_to_km
from ..models import Coords, Event
from ..serializers import EventSerializer


class EventsView(APIView):

  def get(self, request, *args, **kwargs):
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
    return JsonResponse(data)
