from django.contrib.auth.models import User
from django.db import models

from bleachfields import BleachTextField
from enumfields import EnumIntegerField

from .enums import Frequency
from .uslocation import UsLocation


class Event(models.Model):
  name        = BleachTextField(max_length=512)
  description = BleachTextField(max_length=2048, null=True)
  start       = models.DateTimeField()
  end         = models.DateTimeField()
  frequency   = EnumIntegerField(Frequency, default=Frequency.none)
  location    = models.ForeignKey(UsLocation, related_name='+')
  contact     = models.ForeignKey(User, related_name="events", null=True)
