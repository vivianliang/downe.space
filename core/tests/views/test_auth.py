from core.serializers import UserSerializer
from DowneSpace.test import TestCase


class AuthViewTest(TestCase):
  url = '/api/auth/'

  def test_logged_in(self):
    response = self.client.get(self.url)
    user_data = UserSerializer(self.user).data
    user_data['is_authenticated'] = True
    self.assertResponseEqual(response, user_data)

  def test_logged_out(self):
    self.client.logout()
    response = self.client.get(self.url)
    self.assertResponseEqual(response, {'is_authenticated': False})
