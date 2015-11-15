from django.http import JsonResponse
from rest_framework.views import APIView

from ..models import Event
from ..serializers import EventSerializer


class EventsView(APIView):

  def get(self, request, *args, **kwargs):
    events = Event.objects.all()
    return JsonResponse(EventSerializer(events, many=True).data, safe=False)
