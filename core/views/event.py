from django.http import JsonResponse
from rest_framework.views import APIView

from ..models import Event
from ..serializers import EventSerializer


class EventView(APIView):

  def get(self, request, event_id, *args, **kwargs):
    try:
      # event = Event.objects.get(id=event_id)
      events = Event.objects.all()
    except Event.DoesNotExist:
      raise Exception('invalid user id')

    return JsonResponse(EventSerializer(events, many=True).data)
