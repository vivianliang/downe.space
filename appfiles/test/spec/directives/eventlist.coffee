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

  afterEach ->
    this.$httpBackend.verifyNoOutstandingExpectation()
    this.$httpBackend.verifyNoOutstandingRequest()

  it 'should get events on start', ->
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

    this.$httpBackend.expectGET("/api/events/?page=1").respond expectedResponse
    this.createController()
    this.$httpBackend.flush()
    expect(this.controller.events).toEqual events

  it 'should get more events', ->
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

    this.$httpBackend.expectGET("/api/events/?page=1").respond expectedResponse
    this.createController()
    this.$httpBackend.flush()

    expect(this.controller.events).toEqual events
    expect(this.controller.more).toBe true
    expect(this.controller.nextPage).toEqual 2

    expectedResponse.more = false

    this.controller.getEvents()
    this.$httpBackend.expectGET("/api/events/?page=2").respond expectedResponse
    this.$httpBackend.flush()

    expect(this.controller.more).toBe false
