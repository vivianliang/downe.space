from django.db import models

from localflavor.us.models import USStateField, USZipCodeField, PhoneNumberField


class UsLocation(models.Model):
  address_1    = models.CharField(max_length=128)
  address_2    = models.CharField(max_length=128, null=True)
  city         = models.CharField(max_length=128)
  state        = USStateField()
  zip_code     = USZipCodeField()
  phone_number = PhoneNumberField(null=True)
