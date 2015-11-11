from rest_framework import serializers
from .coords import CoordsSerializer
from .user import UserSerializer
from ..models import Event


class EventSerializer(serializers.Serializer):
  id          = serializers.IntegerField()
  name        = serializers.CharField(max_length=512)
  description = serializers.CharField(max_length=2048)
  start       = serializers.DateTimeField()
  end         = serializers.DateTimeField()
  frequency   = serializers.IntegerField()
  location    = serializers.CharField(max_length=2048)
  coords      = CoordsSerializer(required=False, many=True)
  contact     = UserSerializer()

  class Meta:
    model = Event
