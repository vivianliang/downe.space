from django.conf.urls import url
from .views import EventView, AuthView, LogoutView

urlpatterns = [
  url(r'^event/(?P<event_id>[0-9]+)/$', EventView.as_view()),
  url(r'^auth/$', AuthView.as_view()),
  url(r'^logout/$', LogoutView.as_view())
]
