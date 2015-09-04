from django.contrib.auth.models import User
from django.db import models

from enumfields import EnumIntegerField

from .enums import Frequency
from .uslocation import UsLocation


class Event(models.Model):
  name        = models.CharField(max_length=128)
  description = models.TextField()
  start_date  = models.DateTimeField()
  end_date    = models.DateTimeField()
  frequency   = EnumIntegerField(Frequency, default=Frequency.none)
  location    = models.ForeignKey(UsLocation, related_name='+')
  contact     = models.ForeignKey(User, related_name="events")
