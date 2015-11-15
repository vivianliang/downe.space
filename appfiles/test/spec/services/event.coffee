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

  it 'should get all events', ->
    expectedResponse = [
      {id: 1, name: 'name1', description: 'description1'},
      {id: 2, name: 'name2', description: 'description2'}
    ]

    result = null
    Event.getEvents().then (data) ->
      result = data
      return

    httpBackend.expectGET("/api/events/").respond expectedResponse
    httpBackend.flush()
    expect(result).toEqual expectedResponse

  it 'should get a single events', ->
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
