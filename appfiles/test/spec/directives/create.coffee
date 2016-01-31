'use strict'

describe 'Directive: create', ->

  beforeEach ->
    module 'downespace'

    inject ($controller, $location, $rootScope, $q, $httpBackend, Event, Upload) ->
      this.$rootScope   = $rootScope.$new()
      this.$controller  = $controller
      this.$location    = $location
      this.$httpBackend = $httpBackend
      this.Event        = Event
      this.Upload       = Upload
      this.$q           = $q

    this.controller = this.$controller 'createController',
      $rootScope: this.$rootScope
      Event     : this.Event
      Upload    : this.Upload

    spyOn(this.Event, 'create').and.returnValue this.$q.when {id: 2, name: 'name'}
    spyOn(this.Upload, 'base64DataUrl').and.returnValue this.$q.when 'data:image/png;base64,foo'
    spyOn(this.$location, 'url').and.returnValue this.$q.when()

    this.$httpBackend.expectGET("/api/auth/").respond {}

  afterEach ->
    this.$httpBackend.verifyNoOutstandingExpectation()
    this.$httpBackend.verifyNoOutstandingRequest()

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
    expect(this.controller.newEvent.name).toBe null
    expect(this.controller.newEvent.description).toBe null
    expect(this.$location.url).toHaveBeenCalledWith '/event/2'

  it 'should convert image to base64', ->
    this.controller.imageFile =
      name: "mockfile.jpg"
      size: 1024
      type: "image/jpeg"

    this.controller.convertImage()

    expect(this.Upload.base64DataUrl).toHaveBeenCalledWith this.controller.imageFile

    this.$httpBackend.flush()
    expect(this.controller.newEvent.image).toEqual 'data:image/png;base64,foo'
