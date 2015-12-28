from django import forms
from django.contrib.auth.models import User
from django.core.files.images import get_image_dimensions
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
  image       = forms.CharField(required=False)


class EditEventForm(Form):
  name        = forms.CharField(required=False)
  description = forms.CharField(required=False)  # will return '' if empty
  start       = TimestampField(required=False)
  end         = TimestampField(required=False)
  frequency   = forms.IntegerField(required=False)
  location    = forms.CharField(required=False)


class PictureForm(Form):
  picture = forms.ImageField()

  def clean(self):
    cleaned_data = super(PictureForm, self).clean()
    picture = cleaned_data.get('picture')
    print 'clean picture'

    if picture:
      max_width = max_height = 1000

      width, height = get_image_dimensions(picture)
      if width > max_width or height > max_height:
        raise forms.ValidationError(
          'Use an image that is %s x %s pixels or smaller.' % (max_width, max_width))

      main, sub = picture.content_type.split('/')
      if not (main == 'image' and sub in ['jpeg', 'pjpeg', 'gif', 'png']):
        raise forms.ValidationError('Please use a JPEG, GIF or PNG image.')
