from django.http import JsonResponse
from rest_framework.views import APIView

from ..models import Event
from ..serializers import EventSerializer


class EventView(APIView):

  def get(self, request, event_id, *args, **kwargs):
    try:
      event = Event.objects.get(id=event_id)
    except Event.DoesNotExist:
      raise Exception('invalid event id')

    return JsonResponse(EventSerializer(event).data, safe=False)
