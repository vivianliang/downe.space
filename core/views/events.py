from django.http import JsonResponse
from rest_framework.views import APIView

from ..models import Event
from ..serializers import EventSerializer


class EventsView(APIView):

  def get(self, request, event_id=None, *args, **kwargs):
    if event_id is not None:
      try:
        event = Event.objects.get(id=event_id)
      except Event.DoesNotExist:
        raise Exception('invalid user id')
      data = EventSerializer(event).data

    else:
      events = Event.objects.all()
      data   = EventSerializer(events, many=True).data

    return JsonResponse(data, safe=False)
