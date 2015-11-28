from DowneSpace.test import TestCase


class EventsViewTest(TestCase):
  url = '/api/events/'

  def test_no_events(self):
    response = self.client.get(self.url)
    emptyResponse = {'page': 1, 'total_pages': 1, 'events': [], 'more': False}
    self.assertResponseEqual(response, emptyResponse)

  def test_pagination(self):
    for _ in range(15):
      self.create_event()

    response = self.client.get(self.url)
    data = self.getJsonResponse(response)

    self.assertEqual(data['page'], 1)
    self.assertEqual(data['total_pages'], 2)
    self.assertEqual(len(data['events']), 9)
    self.assertEqual(data['more'], True)

    response = self.client.get(self.url, {'page': 2})
    data = self.getJsonResponse(response)

    self.assertEqual(data['page'], 2)
    self.assertEqual(data['total_pages'], 2)
    self.assertEqual(len(data['events']), 6)
    self.assertEqual(data['more'], False)

  def test_filter_location(self):
    # coords for 1149 22nd St, San Francisco, CA - 22nd St Caltrain station
    lat = 37.757528
    lon = -122.392687

    # coords for 700 Fourth St, San Francisco, CA - 4th and King Caltrain station
    event1 = self.create_event(name='event1', lat=37.776665, lon=-122.394706)

    # coords for 95 University Ave, Palo Alto, CA - Palo Alto Caltrain station
    self.create_event(name='event2', lat=37.443425, lon=-122.165174)

    # 10 mile range
    response = self.client.get(self.url, {'lat': lat, 'lon': lon, 'range': 10})
    data = self.getJsonResponse(response)

    self.assertEqual(len(data['events']), 1)
    self.assertEqual(data['events'][0]['name'], event1.name)

    # 30 mile range
    response = self.client.get(self.url, {'lat': lat, 'lon': lon, 'range': 30})
    data = self.getJsonResponse(response)

    self.assertEqual(len(data['events']), 2)
