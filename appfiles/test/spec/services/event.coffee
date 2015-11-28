'use strict'

describe 'Service: Event', ->

  beforeEach ->
    module 'downespace'
    inject (Event, $httpBackend, $rootScope, Date) ->
      this.Event        = Event
      this.$httpBackend = $httpBackend
      this.$scope       = $rootScope.$new()

    this.$httpBackend.expectGET('/api/auth/').respond {}

    this.timestamp = 1420095600
    this.dateString = '01/01/2015 12:00AM'

  it 'should get paged events', ->
    events = [
      {
        id         : 1
        name       : 'name1'
        description: 'description1'
        start      : this.timestamp
        end        : this.timestamp
      },
      {
        id         : 2
        name       : 'name2'
        description: 'description2'
        start      : this.timestamp
        end        : this.timestamp
      }
    ]
    expectedResponse =
      page       : 1
      total_pages: 2
      events     : events
      more       : true

    transformedResponse = angular.copy expectedResponse
    transformedResponse.events = this.Event.processEvents transformedResponse.events

    result = null
    this.Event.getEvents().then (data) ->
      result = data
      return

    this.$httpBackend.expectGET('/api/events/?page=1').respond expectedResponse
    this.$httpBackend.flush()
    expect(result).toEqual transformedResponse

    this.Event.getEvents(page=2)
    this.$httpBackend.expectGET('/api/events/?page=2').respond events: []
    this.$httpBackend.flush()

  it 'should get a single event', ->
    eventId = 1
    expectedResponse =
      id         : eventId
      name       : 'name'
      description: 'description'
      start      : 1420070400
      end        : 1420070400

    transformedResponse = this.Event.processEvent expectedResponse

    result = null
    this.Event.getEvent(eventId).then (data) ->
      result = data
      return

    this.$httpBackend.expectGET("/api/event/#{ eventId }/").respond expectedResponse
    this.$httpBackend.flush()
    expect(result).toEqual transformedResponse

  it 'should process events properly', ->
    event =
      id         : 1
      name       : 'name'
      description: 'description'
      start      : 1420070400
      end        : 1420070400

    processedEvent = this.Event.processEvent event
    expect(processedEvent.id).toEqual event.id
    expect(processedEvent.name).toEqual event.name
    expect(processedEvent.description).toEqual event.description
    expect(processedEvent.start).toEqual moment.unix(event.start).format 'MM/DD/YYYY hh:mm A'
    expect(processedEvent.end).toEqual moment.unix(event.end).format 'MM/DD/YYYY hh:mm A'
