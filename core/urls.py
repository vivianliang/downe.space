from django.conf.urls import url
from . import views
from .views_new import EventView

urlpatterns = [
  url(r'^$', views.index, name='index'),
  # ex: /5/
  url(r'^(?P<event_id>[0-9]+)/$', views.event, name='event'),
  url(r'^event/(?P<event_id>[0-9]+)/$', EventView.as_view())
]
