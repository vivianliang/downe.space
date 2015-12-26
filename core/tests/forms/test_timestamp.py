from datetime import datetime

from django.forms import Form

from core.forms.fields import TimestampField
from DowneSpace.test import TestCase


class TestForm(Form):
  timestamp = TimestampField()


class TimestampFieldTest(TestCase):
  # timestamp of date '2015-01-01 00:00:00'
  unix_timestamp = 1420070400
  date = datetime.fromtimestamp(unix_timestamp)

  def test_field(self):
    test_data = {'timestamp': self.unix_timestamp}
    test_form = TestForm(test_data)
    self.assertTrue(test_form.is_valid())
    self.assertEqual(test_form.cleaned_data['timestamp'], self.date)

  def test_field_required(self):
    test_data = {}
    test_form = TestForm(test_data)
    self.assertFalse(test_form.is_valid())
    self.assertEqual(test_form.errors['timestamp'], ['This field is required.'])

  def test_field_empty(self):
    test_data = {'timestamp': ''}
    test_form = TestForm(test_data)
    self.assertFalse(test_form.is_valid())
    self.assertEqual(test_form.errors['timestamp'], ['This field is required.'])

  def test_field_invalid(self):
    test_data = {'timestamp': 'foo'}
    test_form = TestForm(test_data)
    self.assertFalse(test_form.is_valid())
    self.assertEqual(test_form.errors['timestamp'], ['Enter a valid unix timestamp.'])
