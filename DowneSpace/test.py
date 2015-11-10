from django.contrib.auth.models import User
from django.test import TestCase as BaseTestCase
from simplejson import loads


class TestCase(BaseTestCase):

  def setUp(self):
    super(TestCase, self).setUp()
    self.user = self.create_user()
    self.client.login(username=self.user.username, password='foo')

  def assertResponseEqual(self, response, results):
    self.assertEqual(loads(response.content), results)

  def create_user(self):
    username = 'username%s' % (User.objects.count() + 1)
    user = User(username=username)
    user.set_password('foo')
    user.save()
    return user
