from django.core.paginator import EmptyPage, Paginator
from django.http import JsonResponse
from rest_framework.views import APIView

from ..models import Event
from ..serializers import EventSerializer


class EventsView(APIView):

  def get(self, request, *args, **kwargs):
    all_events = Event.objects.all()
    # 9 events per page
    paginator = Paginator(all_events, 9)

    page = int(request.GET.get('page', 1))
    try:
      events = paginator.page(page)
    except EmptyPage:
      events = paginator.page(paginator.num_pages)

    data = {
      'events'     : EventSerializer(events, many=True).data,
      'total_pages': paginator.num_pages,
      'page'       : page,
      'more'       : page < paginator.num_pages
    }
    return JsonResponse(data)
