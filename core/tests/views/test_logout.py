from django.conf import settings

from DowneSpace.test import TestCase


class LogoutViewTest(TestCase):

  def test_logout(self):
    response = self.client.get('/api/logout/')
    self.assertRedirects(response, settings.APP_URL, target_status_code=302)

    # confirm logged out
    response = self.client.get('/api/auth/')
    self.assertResponseEqual(response, {'is_authenticated': False})
