from bleachfields import BleachTextField
from django.db import models

from .event import Event


class Category(models.Model):
  events = models.ManyToManyField(Event, related_name='categories')
  name   = BleachTextField(max_length=64)

  def __unicode__(self):
    return u'%d %s' % (self.id, self.name)

  class Meta:
    verbose_name_plural = 'categories'
