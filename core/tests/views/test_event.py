from mock import patch

from DowneSpace.test import TestCase


class EventViewTest(TestCase):

  def test_get_event(self):
    event    = self.create_event(name='event')
    response = self.client.get('/api/event/%s/' % event.id)
    result   = self.getJsonResponse(response)
    self.assertEqual(result['name'], 'event')

  def test_create_event(self):
    with patch('core.receivers.get_coords'):
      response = self.client.post('/api/event/', {'name': 'event'})
    result = self.getJsonResponse(response)
    self.assertEqual(result['name'], 'event')
