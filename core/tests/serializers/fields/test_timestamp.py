from datetime import datetime

from rest_framework.serializers import Serializer

from core.serializers.fields import TimestampField
from DowneSpace.test import TestCase


class TestSerializer(Serializer):
  timestamp = TimestampField()


class TestObject(object):
  def __init__(self):
    return


class TimestampFieldTest(TestCase):
  # timestamp of date '2015-01-01 00:00:00'
  unix_timestamp = 1420070400
  date = datetime.fromtimestamp(unix_timestamp)

  def test_field(self):
    test_object = TestObject()
    test_object.timestamp = self.date
    test_data = TestSerializer(test_object).data
    self.assertEqual(test_data['timestamp'], self.unix_timestamp)
