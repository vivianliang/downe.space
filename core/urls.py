from django.conf.urls import url
from .views import EventView, AuthView

urlpatterns = [
  url(r'^event/(?P<event_id>[0-9]+)/$', EventView.as_view()),
  url(r'^auth/$', AuthView.as_view())
]
