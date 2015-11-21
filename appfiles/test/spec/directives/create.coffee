'use strict'

describe 'Directive: create', ->

  beforeEach ->
    module 'downespace'

    inject ($rootScope, $controller, $q, _Event_) ->
      this.$rootScope  = $rootScope.$new()
      this.$controller = $controller
      this.Event       = _Event_
      this.$q          = $q

    this.controller = this.$controller 'createController',
      $rootScope: this.$rootScope
      Event     : this.Event

  it 'should create an event', ->

    this.controller.newEvent =
      name       : 'name'
      description: 'description'
      start      : '2015-01-01'
      end        : '2015-01-02'
      frequency  : 1
      location   : '123 loop ave. palo alto, ca'

    spyOn(this.Event, 'create').and.returnValue this.$q.when this.controller.newEvent

    this.controller.createEvent()

    expect(this.Event.create).toHaveBeenCalledWith this.controller.newEvent
