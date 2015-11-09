from rest_framework import serializers


class UserSerializer(serializers.Serializer):
  id         = serializers.IntegerField()
  first_name = serializers.CharField()
  last_name  = serializers.CharField()
  name       = serializers.CharField(source='get_full_name')
