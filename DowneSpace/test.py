from datetime import timedelta

from django.contrib.auth.models import User
from django.test import TestCase as BaseTestCase
from django.utils import timezone
from mock import patch
from simplejson import loads

from core.models import Event


class TestCase(BaseTestCase):

  def setUp(self):
    super(TestCase, self).setUp()
    self.now = timezone.now()
    self.user = self.create_user()
    self.client.login(username=self.user.username, password='foo')

  def getJsonResponse(self, response):
    return loads(response.content)

  def assertResponseEqual(self, response, results):
    if response.content:
      self.assertEqual(loads(response.content), results)
    else:
      raise Exception('no response content found')

  def create_user(self):
    username = 'username%s' % (User.objects.count() + 1)
    user = User(username=username)
    user.set_password('foo')
    user.save()
    return user

  def create_event(self, name='', description='', start=None, end=None,
    lat=None, lon=None, user=None):
      with patch('core.receivers.get_coords') as get_coords:
        get_coords.return_value = {'lat': lat or 1.0, 'lng': lon or 1.0}
        return Event.objects.create(
          name        = name,
          description = description,
          start       = start or self.now,
          end         = end or self.now + timedelta(days=1),
          contact     = user or self.user)
