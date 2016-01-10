import csv
import datetime
from calendar import timegm
from os import environ

import requests
from django.contrib.auth.models import User
from django.core.management.base import BaseCommand
from django.db import transaction

from core.forms import EventForm
from core.models import Event


class Command(BaseCommand):

  def _format_datestring(self, datestring):
    time = datetime.datetime.strptime(datestring, '%d/%m/%Y %H:%M:%S') + datetime.timedelta(hours=8)
    return timegm(time.timetuple())

  def handle(self, *args, **options):
    events = []
    url    = environ.get('EVENT_DOC_URL', '')

    if url == '':
      print 'no event doc url detected, exiting.'
      return

    csvfile = requests.get(url)

    text    = csvfile.text.encode('ISO-8859-1')
    reader  = csv.reader(text.splitlines(), delimiter=',')
    user_id = User.objects.first().id

    # ignore first row as it only contains column names
    reader.next()

    for row in reader:
      if Event.objects.filter(name=row[0]).exists():
        return

      event = {
        'name'       : row[0],
        'description': row[1],
        'start'      : self._format_datestring(row[2]),
        'end'        : self._format_datestring(row[3]),
        'frequency'  : 1,
        'location'   : row[5],
        'contact'    : user_id
      }
      events.append(event)

    for e in events:
      event_form = EventForm(e)
      event_form.is_valid()
      with transaction.atomic():
        Event.objects.create(**event_form.cleaned_data)
