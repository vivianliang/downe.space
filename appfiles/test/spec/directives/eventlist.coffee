'use strict'

describe 'Directive: eventList', ->

  beforeEach ->
    module 'downespace'

    inject ($rootScope, $controller, $q, $httpBackend, Event) ->
      this.$rootScope   = $rootScope.$new()
      this.$controller  = $controller
      this.$httpBackend = $httpBackend
      this.Event        = Event
      this.$q           = $q

    this.createController = =>
      this.controller = this.$controller 'eventListController',
        $rootScope: this.$rootScope
      , this.$rootScope
      this.$rootScope.$digest()
      return

    this.$httpBackend.expectGET("/api/auth/").respond {}

    this.timestamp = 1420095600

    this.events = [
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

    this.expectedResponse = {
      page       : 1
      total_pages: 2
      events     : this.events
      more       : true
    }


  afterEach ->
    this.$httpBackend.verifyNoOutstandingExpectation()
    this.$httpBackend.verifyNoOutstandingRequest()

  it 'should get events on start', ->
    this.$httpBackend.expectGET("/api/events/?page=1").respond this.expectedResponse
    this.createController()
    this.$httpBackend.flush()
    expect(this.controller.events).toEqual this.Event.processEvents(this.events)

  it 'should get more events', ->
    this.$httpBackend.expectGET("/api/events/?page=1").respond this.expectedResponse
    this.createController()
    this.$httpBackend.flush()

    expect(this.controller.events).toEqual this.Event.processEvents(this.events)
    expect(this.controller.more).toBe true
    expect(this.controller.nextPage).toEqual 2

    this.expectedResponse.more = false

    this.controller.getEvents()
    this.$httpBackend.expectGET("/api/events/?page=2").respond this.expectedResponse
    this.$httpBackend.flush()

    expect(this.controller.more).toBe false
