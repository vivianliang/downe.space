'use strict'

describe 'Service: Event', ->

  beforeEach ->
    module 'downespace'
    inject ($rootScope, $httpBackend, Event) ->
      this.Event        = Event
      this.$httpBackend = $httpBackend
      this.$scope       = $rootScope.$new()
      return

    this.$httpBackend.expectGET('/api/auth/').respond {}

    # 2015-01-01 00:00:00 UTC
    this.timestamp = 1420070400
    return

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
    return

  it 'should get a single event', ->
    eventId = 1
    expectedResponse =
      id         : eventId
      name       : 'name'
      description: 'description'
      start      : this.timestamp
      end        : this.timestamp

    transformedResponse = this.Event.processEvent expectedResponse

    result = null
    this.Event.getEvent(eventId).then (data) ->
      result = data
      return

    this.$httpBackend.expectGET("/api/event/#{ eventId }/").respond expectedResponse
    this.$httpBackend.flush()
    expect(result).toEqual transformedResponse
    return

  it 'should process events properly', ->
    event =
      id         : 1
      name       : 'name'
      description: 'description'
      start      : this.timestamp
      end        : this.timestamp

    processedEvent = this.Event.processEvent event
    expect(processedEvent.id).toEqual event.id
    expect(processedEvent.name).toEqual event.name
    expect(processedEvent.description).toEqual event.description
    expect(processedEvent.start).toEqual moment.unix(event.start).format 'ddd, MMM D, h:mm A'
    expect(processedEvent.end).toEqual moment.unix(event.end).format 'ddd, MMM D, h:mm A'
    return

  it 'should create an event', ->
    event =
      name       : 'foo'
      description: 'bar'
      start      : moment.unix this.timestamp
      end        : moment.unix this.timestamp

    transformedEvent       = angular.copy event
    transformedEvent.start = this.timestamp
    transformedEvent.end   = this.timestamp

    this.Event.create event
    this.$httpBackend.expectPOST('/api/events/', transformedEvent).respond {}
    this.$httpBackend.flush()

    # make sure original event object is unchanged
    expect(event.start).toEqual moment.unix(this.timestamp)
    expect(event.end).toEqual moment.unix(this.timestamp)
    return

  it 'should edit an event', ->
    event =
      id         : 1
      name       : 'foo'
      description: 'bar'
      start      : moment.unix this.timestamp
      end        : moment.unix this.timestamp

    transformedEvent       = angular.copy event
    transformedEvent.start = this.timestamp
    transformedEvent.end   = this.timestamp

    this.Event.edit event
    this.$httpBackend.expectPUT("/api/event/#{ event.id }/", transformedEvent).respond {}
    this.$httpBackend.flush()

    # make sure original event object is unchanged
    expect(event.start).toEqual moment.unix(this.timestamp)
    expect(event.end).toEqual moment.unix(this.timestamp)
    return
  return
