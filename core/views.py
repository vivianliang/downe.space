from django.http import HttpResponse
from django.template import RequestContext, loader
from .models import Event


def index(request):
  events = Event.objects.all().order_by('id')
  template = loader.get_template('core/index.html')
  context = RequestContext(request, {
    'events': events
  })
  return HttpResponse(template.render(context))


def event(request, event_id):
  event = Event.objects.get(id=event_id)
  categories = event.categories.all()
  template = loader.get_template('core/event.html')
  context = RequestContext(request, {
    'event'     : event,
    'categories': categories
  })
  return HttpResponse(template.render(context))
