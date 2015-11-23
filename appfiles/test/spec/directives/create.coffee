'use strict'

describe 'Directive: create', ->

  beforeEach ->
    module 'downespace'

    inject ($rootScope, $controller, $q, $httpBackend, Event) ->
      this.$rootScope   = $rootScope.$new()
      this.$controller  = $controller
      this.$httpBackend = $httpBackend
      this.Event        = Event
      this.$q           = $q

    this.controller = this.$controller 'createController',
      $rootScope: this.$rootScope
      Event     : this.Event

    this.$httpBackend.expectGET("/api/auth/").respond {}
    spyOn(this.Event, 'create').and.returnValue this.$q.when this.controller.newEvent

  afterEach ->
    this.$httpBackend.verifyNoOutstandingExpectation()
    this.$httpBackend.verifyNoOutstandingRequest()

  it 'should reset events on start', ->
    this.$httpBackend.flush()
    this.$rootScope.$digest()
    expect(this.controller.newEvent).toEqual {}

  it 'should create an event', ->

    this.controller.newEvent =
      name       : 'name'
      description: 'description'
      start      : '2015-01-01'
      end        : '2015-01-02'
      frequency  : 1
      location   : '123 loop ave. palo alto, ca'

    this.controller.createEvent()

    expect(this.Event.create).toHaveBeenCalledWith this.controller.newEvent

    this.$httpBackend.flush()
    this.$rootScope.$digest()
    expect(this.controller.newEvent).toEqual {}
