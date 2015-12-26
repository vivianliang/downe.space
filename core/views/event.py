from django.core.exceptions import ValidationError
from django.db import transaction
from rest_framework.response import Response
from rest_framework.views import APIView

from ..forms import EditEventForm
from ..models import Event
from ..serializers import EventSerializer


class EventView(APIView):

  def initial(self, request, event_id, *args, **kwargs):
    try:
      request.event = Event.objects.get(id=event_id)
    except Event.DoesNotExist:
      raise Exception('invalid event id')
    return super(EventView, self).initial(request, args, kwargs)

  def get(self, request, event_id, *args, **kwargs):
    '''Get an event.'''
    return Response(EventSerializer(request.event).data)

  def put(self, request, event_id, *args, **kwargs):
    '''Edit an event.'''
    event = request.event

    # TODO: define permissions to use with DRF in the correct way
    if request.user.id is not event.contact.id:
      raise Exception('user does not have permission to edit event')

    event_form = EditEventForm(request.data)

    if not event_form.is_valid():
      raise ValidationError(event_form.errors)

    updated_fields = []
    for key, value in event_form.cleaned_data.iteritems():
      if not value or getattr(event, key) == value:
        continue
      setattr(event, key, value)
      updated_fields.append(key)

    with transaction.atomic():
      event.save(update_fields=updated_fields)

    return Response(EventSerializer(event).data)
