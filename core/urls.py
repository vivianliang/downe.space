from django.conf.urls import url
from .views import EventsView, AuthView, LogoutView

urlpatterns = [
  url(r'^auth/$', AuthView.as_view()),
  url(r'^events/$', EventsView.as_view()),
  url(r'^events/(?P<event_id>[0-9]+)/$', EventsView.as_view()),
  url(r'^logout/$', LogoutView.as_view())
]
