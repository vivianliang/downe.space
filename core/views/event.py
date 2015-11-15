from datetime import datetime

from django import forms
from django.db import transaction
from django.forms import Form
from django.http import JsonResponse
from django.utils import timezone
from rest_framework.response import Response
from rest_framework.views import APIView

from ..models import Event
from ..serializers import EventSerializer


class EventForm(Form):
  name        = forms.CharField()
  description = forms.CharField()  # will return '' if empty
  start       = forms.DateField()
  end         = forms.DateField()
  frequency   = forms.IntegerField()
  location    = forms.CharField()
  contact     = forms.Field()


class EventView(APIView):

  def get(self, request, event_id, *args, **kwargs):
    '''Get an event'''
    try:
      event = Event.objects.get(id=event_id)
    except Event.DoesNotExist:
      raise Exception('invalid event id')

    return JsonResponse(EventSerializer(event).data, safe=False)

  def post(self, request, *args, **kwargs):
    '''Create a new event.'''
    time_format = '%Y-%m-%dT%H:%M:%S.%fZ'

    now = timezone.now()

    start = request.data.get('start')
    start = datetime.strptime(start, time_format) if start else now

    end = request.data.get('end')
    end = datetime.strptime(end, time_format) if end else now

    with transaction.atomic():
      event = Event.objects.create(
        name        = request.data.get('name') or '',
        description = request.data.get('description' or ''),
        start       = start or now,
        end         = end or now,
        frequency   = request.data.get('frequency') or 0,
        location    = request.data.get('location') or '',
        contact_id  = request.user.id)

    return Response(EventSerializer(event).data)
