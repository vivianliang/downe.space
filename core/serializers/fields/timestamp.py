from calendar import timegm

from rest_framework.serializers import DateTimeField


class TimestampField(DateTimeField):
  def to_representation(self, value):
    return timegm(value.timetuple())
