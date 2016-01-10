'use strict'

angular.module('downespace').directive 'create', ->
  directive =
    controller  : 'createController'
    controllerAs: 'create'
    restrict    : 'E'
    templateUrl : 'views/directives/create.html'
  return directive

angular.module('downespace').controller 'createController', ($rootScope, Event, Upload) ->

  this.imageFile = null

  resetEvent = =>
    this.newEvent =
      name       : null
      description: null
      start      : null
      end        : null
      frequency  : null
      location   : null
      url        : null
      image      : null

    return

  this.convertImage = =>
    Upload.base64DataUrl(this.imageFile).then (data) =>
      this.newEvent.image = data
      return
    return

  this.createEvent = =>
    Event.create(this.newEvent).then (createdEvent) ->
      resetEvent()
      return
    return

  resetEvent()
  return
