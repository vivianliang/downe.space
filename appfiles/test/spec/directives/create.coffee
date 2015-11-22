'use strict'

describe 'Directive: create', ->

  beforeEach ->
    module 'downespace'

    inject ($rootScope, $controller, $q, $httpBackend, _Event_) ->
      this.$rootScope   = $rootScope.$new()
      this.$controller  = $controller
      this.$httpBackend = $httpBackend
      this.Event        = _Event_
      this.$q           = $q

    this.controller = this.$controller 'createController',
      $rootScope: this.$rootScope
      Event     : this.Event

  it 'should prepopulate default dates', ->
    startOfDay = moment().startOf('day').toDate()
    endOfDay = moment().endOf('day').seconds(0).milliseconds(0).toDate()

    expect(this.controller.newEvent.start).toEqual startOfDay
    expect(this.controller.newEvent.end).toEqual endOfDay

  it 'should create an event', ->

    this.controller.newEvent =
      name       : 'name'
      description: 'description'
      start      : '2015-01-01'
      end        : '2015-01-02'
      frequency  : 1
      location   : '123 loop ave. palo alto, ca'

    this.$httpBackend.expectGET("/api/auth/").respond {}
    spyOn(this.Event, 'create').and.returnValue this.$q.when this.controller.newEvent

    this.controller.createEvent()

    expect(this.Event.create).toHaveBeenCalledWith this.controller.newEvent

    this.$rootScope.$digest()
    expect(this.controller.newEvent.name).toBeUndefined()
    expect(this.controller.newEvent.description).toBeUndefined()
    expect(this.controller.newEvent.frequency).toBeUndefined()
    expect(this.controller.newEvent.location).toBeUndefined()
