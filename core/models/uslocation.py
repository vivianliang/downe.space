from django.db import models

from django_localflavor_us.models import USStateField


class UsLocation(models.Model):
  address_1 = models.CharField(max_length=128)
  address_2 = models.CharField(max_length=128)
  city      = models.CharField(max_length=128)
  state     = USStateField()
  zip_code  = models.CharField(max_length=5)
