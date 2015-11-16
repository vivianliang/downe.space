from django.contrib.auth.models import User
from django.test import TestCase as BaseTestCase
from django.utils import timezone
from mock import patch
from simplejson import loads

from core.models import Event


class TestCase(BaseTestCase):

  def setUp(self):
    super(TestCase, self).setUp()
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

  @patch('core.receivers.get_coords')
  def create_event(self, get_coords_mock):
    return Event.objects.create(start=timezone.now(), end=timezone.now())
