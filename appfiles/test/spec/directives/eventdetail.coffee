'use strict'

describe 'Directive: eventDetail', ->

  beforeEach ->
    module 'downespace'

    inject ($rootScope, $controller, $q, $httpBackend, $routeParams, Event) ->
      this.$rootScope   = $rootScope.$new()
      this.$controller  = $controller
      this.$httpBackend = $httpBackend
      this.$routeParams = $routeParams
      this.Event        = Event
      this.$q           = $q

    this.$routeParams = id: 1

    this.createController = =>
      this.controller = this.$controller 'eventDetailController',
        $rootScope  : this.$rootScope
        $routeParams: this.$routeParams
      , this.$rootScope
      this.$rootScope.$digest()
      return

    this.$httpBackend.expectGET("/api/auth/").respond {}

    this.eventResponse =
      id         : 1
      name       : 'name'
      description: 'description'

  afterEach ->
    this.$httpBackend.verifyNoOutstandingExpectation()
    this.$httpBackend.verifyNoOutstandingRequest()

  it 'should get event based on event id in routeparams', ->
    this.$httpBackend.expectGET("/api/event/1/").respond this.eventResponse
    this.createController()
    expect(this.controller.eventId).toBe 1

    this.$httpBackend.flush()
    expect(this.controller.event.id).toBe 1
    expect(this.controller.event.name).toBe 'name'
