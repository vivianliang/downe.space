from DowneSpace.test import TestCase


class EventsViewTest(TestCase):
  url = '/api/events/'

  def test_no_events(self):
    response = self.client.get(self.url)
    emptyResponse = {'page': 1, 'total_pages': 1, 'events': [], 'more': False}
    self.assertResponseEqual(response, emptyResponse)

  def test_pagination(self):
    for x in range(15):
      self.create_event()

    response = self.client.get(self.url)
    data = self.getJsonResponse(response)

    self.assertEqual(data['page'], 1)
    self.assertEqual(data['total_pages'], 2)
    self.assertEqual(len(data['events']), 12)
    self.assertEqual(data['more'], True)

    response = self.client.get(self.url, {'page': 2})
    data = self.getJsonResponse(response)

    self.assertEqual(data['page'], 2)
    self.assertEqual(data['total_pages'], 2)
    self.assertEqual(len(data['events']), 3)
    self.assertEqual(data['more'], False)
