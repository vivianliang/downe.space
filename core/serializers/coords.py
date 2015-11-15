from rest_framework import serializers


class CoordsSerializer(serializers.Serializer):
  lat = serializers.FloatField()
  lon = serializers.FloatField()
