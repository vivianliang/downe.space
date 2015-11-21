from mock import patch

from DowneSpace.test import TestCase


class EventViewTest(TestCase):

  def test_get_event(self):
    event    = self.create_event(name='event')
    response = self.client.get('/api/event/%s/' % event.id)
    result   = self.getJsonResponse(response)
    self.assertEqual(result['name'], 'event')

  def test_create_event(self):
    event_data = {
      'name'       : 'event',
      'description': 'test description',
      'frequency'  : 1,
      'location'   : '123 loop ave palo alto ca',
      'start'      : '2015-01-01 12:00:00',
      'end'        : '2015-12-31 23:59:00'
    }
    with patch('core.receivers.get_coords'):
      response = self.client.post('/api/event/', event_data)
    result = self.getJsonResponse(response)
    self.assertEqual(result['name'], 'event')
    self.assertEqual(result['description'], 'test description')
    self.assertEqual(result['location'], '123 loop ave palo alto ca')
    self.assertEqual(result['start'], '2015-01-01T12:00:00Z')
    self.assertEqual(result['end'], '2015-12-31T23:59:00Z')
