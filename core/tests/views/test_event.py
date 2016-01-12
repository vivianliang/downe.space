import datetime

from mock import patch
from simplejson import dumps

from DowneSpace.test import TestCase


class EventViewTest(TestCase):

  def test_get_event(self):
    event    = self.create_event(name='event')
    response = self.client.get('/api/event/%s/' % event.id)
    result   = self.getJsonResponse(response)
    self.assertEqual(result['name'], 'event')

  def test_edit_event(self):
    event = self.create_event(name='e', description='d')
    # timestamp of date '2015-01-01 00:00:00'
    unix_timestamp = 1420070400
    date = datetime.datetime(2015, 1, 1, 0, 0)

    event_data = {
      'name'       : 'event',
      'description': 'test description',
      'frequency'  : 1,
      'location'   : '123 loop ave palo alto ca',
      'start'      : unix_timestamp,
      'end'        : unix_timestamp,
      'url'        : 'google.com',
      'image'      : 'data:image/png;base64,foo'
    }
    event_data = dumps(event_data)
    with patch('core.receivers.get_coords') as get_coords:
      get_coords.return_value = {'lat': 2.0, 'lng': 2.0}
      response = self.client.put('/api/event/%s/' % event.id, data=event_data,
        content_type='application/json')

    event.refresh_from_db()
    result = self.getJsonResponse(response)
    self.assertEqual(result['name'], 'event')

    self.assertEqual(event.name, 'event')
    self.assertEqual(event.description, 'test description')
    self.assertEqual(event.location, '123 loop ave palo alto ca')
    self.assertEqual(event.start, date)
    self.assertEqual(event.end, date)
    self.assertEqual(event.url, 'http://google.com')
    self.assertEqual(event.image, 'data:image/png;base64,foo')

    coords = event.coords.first()
    self.assertEqual(coords.lat, 2.0)
    self.assertEqual(coords.lon, 2.0)
