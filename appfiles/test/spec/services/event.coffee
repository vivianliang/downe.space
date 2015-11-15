'use strict'

describe 'Service: Event', ->

  beforeEach module 'downespace'

  Event       = null
  scope       = null
  httpBackend = null

  beforeEach inject (_Event_, $httpBackend, $rootScope) ->
    Event       = _Event_
    httpBackend = $httpBackend
    scope       = $rootScope.$new()

    httpBackend.expectGET("/api/auth/").respond {}

  it 'should get paged events', ->
    events = [
      {id: 1, name: 'name1', description: 'description1'},
      {id: 2, name: 'name2', description: 'description2'}
    ]
    expectedResponse = {
      page       : 1
      total_pages: 2
      events     : events
      more       : true
    }

    result = null
    Event.getEvents().then (data) ->
      result = data
      return

    httpBackend.expectGET("/api/events/?page=1").respond expectedResponse
    httpBackend.flush()
    expect(result).toEqual expectedResponse

    Event.getEvents(page=2)
    httpBackend.expectGET("/api/events/?page=2").respond {}

  it 'should get a single event', ->
    eventId = 1
    expectedResponse =
      id         : eventId
      name       : 'name'
      description: 'description'

    result = null
    Event.getEvent(eventId).then (data) ->
      result = data
      return

    httpBackend.expectGET("/api/event/#{ eventId }/").respond expectedResponse
    httpBackend.flush()
    expect(result).toEqual expectedResponse
