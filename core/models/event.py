from django.contrib.auth.models import User
from django.db import models

from bleachfields import BleachTextField
from enumfields import EnumIntegerField

from .enums import Frequency


class Event(models.Model):
  name        = BleachTextField(max_length=512)
  description = BleachTextField(max_length=2048, null=True)
  start       = models.DateTimeField()
  end         = models.DateTimeField()
  location    = BleachTextField(max_length=2048)
  frequency   = EnumIntegerField(Frequency, default=Frequency.none)
  contact     = models.ForeignKey(User, related_name="events", null=True)
