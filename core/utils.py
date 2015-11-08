from django.http import HttpResponse
from simplejson import dumps


def render_json(data, status=200):
  return HttpResponse(dumps(data), content_type='application/json', status=status)
