from django.http import HttpResponse

from rest_framework.views import APIView
from simplejson import dumps

from ..models import Event
from ..serializers import EventSerializer


def render_json(data, status=200):
  return HttpResponse(dumps(data), content_type='application/json', status=status)


class EventView(APIView):

  def get(self, request, event_id, *args, **kwargs):
    try:
      # event = Event.objects.get(id=event_id)
      events = Event.objects.all()
    except Event.DoesNotExist:
      raise Exception('invalid user id')

    return render_json(EventSerializer(events, many=True).data)
