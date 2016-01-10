from django import forms
from django.contrib.auth.models import User
from django.forms import Form

from .fields import TimestampField


class EventForm(Form):
  name        = forms.CharField(min_length=1)
  description = forms.CharField()  # will return '' if empty
  start       = TimestampField()
  end         = TimestampField()
  frequency   = forms.IntegerField(required=False)
  location    = forms.CharField()
  contact     = forms.ModelChoiceField(queryset=User.objects)
  url         = forms.URLField(required=False)
  image       = forms.CharField(required=False)  # TODO: image validation


class EditEventForm(Form):
  name        = forms.CharField(required=False)
  description = forms.CharField(required=False)  # will return '' if empty
  start       = TimestampField(required=False)
  end         = TimestampField(required=False)
  frequency   = forms.IntegerField(required=False)
  location    = forms.CharField(required=False)
