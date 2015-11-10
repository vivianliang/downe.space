from DowneSpace.test import TestCase


class LogoutViewTest(TestCase):

  def test_logout(self):
    response = self.client.get('/api/logout/')
    self.assertRedirects(response, '/', target_status_code=404, fetch_redirect_response=True)

    # confirm logged out
    response = self.client.get('/api/auth/')
    self.assertResponseEqual(response, {'is_authenticated': False})
