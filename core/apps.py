# flake8: noqa
from django.apps import AppConfig


class CoreAppConfig(AppConfig):

  name = 'core'

  def ready(self):
    import core.receivers  
