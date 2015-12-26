from datetime import datetime

from django.core.exceptions import ValidationError
from django.forms.fields import DateTimeField


class TimestampField(DateTimeField):
  default_error_messages = {'invalid': 'Enter a valid unix timestamp.'}

  def to_python(self, value):
    if value in self.empty_values:
      return None

    try:
      value = datetime.fromtimestamp(int(value))
    except (TypeError, ValueError):
      raise ValidationError(self.error_messages['invalid'], code='invalid')

    return super(TimestampField, self).to_python(value)
