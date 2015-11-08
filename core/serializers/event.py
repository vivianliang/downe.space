from ..models import Event
from rest_framework import serializers


class UserSerializer(serializers.Serializer):
  id         = serializers.IntegerField()
  first_name = serializers.CharField()
  last_name  = serializers.CharField()


class LocationSerializer(serializers.Serializer):
  address_1    = serializers.CharField(max_length=128)
  address_2    = serializers.CharField(max_length=128)
  city         = serializers.CharField(max_length=128)
  state        = serializers.CharField()
  zip_code     = serializers.CharField()
  phone_number = serializers.CharField()


class EventSerializer(serializers.Serializer):
  name        = serializers.CharField(max_length=512)
  description = serializers.CharField(max_length=2048)
  start       = serializers.DateTimeField()
  end         = serializers.DateTimeField()
  frequency   = serializers.IntegerField()
  location    = LocationSerializer()
  contact     = UserSerializer()

  class Meta:
    model = Event
