from django import forms
from django.contrib.auth.models import User
from django.core.exceptions import ValidationError
from django.db import transaction
from django.forms import Form
from django.http import JsonResponse
from rest_framework.response import Response
from rest_framework.views import APIView

from ..models import Event
from ..serializers import EventSerializer


class EventForm(Form):
  name        = forms.CharField()
  description = forms.CharField()  # will return '' if empty
  start       = forms.DateTimeField()
  end         = forms.DateTimeField()
  frequency   = forms.IntegerField()
  location    = forms.CharField()
  contact     = forms.ModelChoiceField(queryset=User.objects)


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
    data = request.data
    data['contact'] = request.user.id
    event_form = EventForm(data)

    if not event_form.is_valid():
      raise ValidationError(event_form.errors)

    with transaction.atomic():
      event = Event.objects.create(**event_form.cleaned_data)

    return Response(EventSerializer(event).data)
