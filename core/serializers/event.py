from rest_framework import serializers

from ..models import Event
from ..serializers.fields import TimestampField
from .coords import CoordsSerializer
from .user import UserSerializer


class EventSerializer(serializers.Serializer):
  id          = serializers.IntegerField()
  name        = serializers.CharField(max_length=512)
  description = serializers.CharField(max_length=2048)
  start       = TimestampField()
  end         = TimestampField()
  frequency   = serializers.IntegerField()
  location    = serializers.CharField(max_length=2048)
  coords      = CoordsSerializer(many=True)
  contact     = UserSerializer()
  url         = serializers.URLField()
  image       = serializers.CharField()

  class Meta:
    model = Event
