from django.conf.urls import url

from .views import AuthView, EventsView, EventView, LogoutView

urlpatterns = [
  url(r'^auth/$', AuthView.as_view()),
  url(r'^event/(?P<event_id>[0-9]+)/$', EventView.as_view()),
  url(r'^events/$', EventsView.as_view()),
  url(r'^logout/$', LogoutView.as_view())
]
