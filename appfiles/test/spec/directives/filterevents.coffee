'use strict'

describe 'Directive: filterEvents', ->

  beforeEach ->
    module 'downespace'

    inject ($controller, $httpBackend, $location, $q, $rootScope, Event) ->
      this.$controller  = $controller
      this.$httpBackend = $httpBackend
      this.$location    = $location
      this.$q           = $q
      this.$scope       = $rootScope.$new()
      this.Event        = Event
      return

    mockAddrData = [
      {
        formatted_address: '123 some street'
        geometry:
          location:
            lat: -> 1
            lng: -> 1
      }
    ]

    this.Address =
      getCoords: jasmine.createSpy('getCoords').and.returnValue this.$q.when mockAddrData
    this.eventList =
      getEvents  : jasmine.createSpy 'getEvents'
      resetEvents: jasmine.createSpy 'resetEvents'

    this.controller = this.$controller 'filterEventsController',
      $location: this.$location
      $scope   : this.$scope
      Event    : this.Event
      Address  : this.Address

    this.controller.eventList = this.eventList

    return

  it 'should toggle expanded', ->
    this.controller.toggle()
    expect(this.controller.expanded).toBe true

    this.controller.toggle()
    expect(this.controller.expanded).toBe false
    return

  it 'should parse url query params', ->
    this.controller.parseParams()
    expect(this.controller.expanded).toBe false

    spyOn(this.$location, 'search').and.returnValue range: 10, location: 94062, foo: 'bar'
    this.controller.parseParams()

    expect(this.controller.location).toEqual 94062
    expect(this.controller.filters.range).toEqual 10
    expect(this.controller.expanded).toBe true
    return

  it 'should set url query params', ->
    this.controller.location = 94062
    this.controller.filters.range = 10
    this.controller.setParams()

    expect(this.$location.search()).toEqual location: 94062, range: 10
    return

  it 'should submit filter changes on load - no filters', ->
    this.$httpBackend.expectGET('/api/auth/').respond {}
    spyOn(this.controller, 'setParams').and.callThrough()
    this.$scope.$digest()

    expect(this.Address.getCoords).not.toHaveBeenCalled()
    expect(this.controller.eventList.resetEvents).toHaveBeenCalledWith()
    expect(this.controller.setParams).toHaveBeenCalledWith()
    expect(this.controller.eventList.filters).toEqual {}
    expect(this.controller.eventList.getEvents).toHaveBeenCalledWith()
    return

  it 'should submit filter changes on load', ->
    this.$httpBackend.expectGET('/api/auth/').respond {}
    spyOn(this.controller, 'setParams').and.callThrough()
    this.controller.location = 94062
    this.$scope.$digest()

    expect(this.Address.getCoords).toHaveBeenCalledWith(94062)
    expect(this.controller.eventList.resetEvents).toHaveBeenCalledWith()
    expect(this.controller.setParams).toHaveBeenCalledWith()
    expect(this.controller.eventList.filters).toEqual lat: 1, lon: 1
    expect(this.controller.eventList.getEvents).toHaveBeenCalledWith()
    return

  it 'should update address on location change', ->
    this.$httpBackend.expectGET('/api/auth/').respond {}
    this.controller.location = 94062
    this.$scope.$digest()

    expect(this.controller.formattedAddress).toEqual '123 some street'
    expect(this.controller.filters.lat).toEqual 1
    expect(this.controller.filters.lon).toEqual 1

    this.controller.location = undefined
    this.$scope.$digest()

    expect(this.controller.formattedAddress).toBeUndefined()
    expect(this.controller.filters.lat).toBeUndefined()
    expect(this.controller.filters.lon).toBeUndefined()
    return

  it 'should delete empty filters', ->
    this.$httpBackend.expectGET('/api/auth/').respond {}
    this.controller.filters = range: undefined
    this.$scope.$digest()

    expect(this.controller.filters).toEqual {}
    return

  return
