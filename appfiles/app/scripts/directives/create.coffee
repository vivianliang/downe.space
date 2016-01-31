'use strict'

app = angular.module 'downespace'

app.directive 'create', ->
  directive =
    controller  : 'createController'
    controllerAs: 'create'
    restrict    : 'E'
    templateUrl : 'views/directives/create.html'
  return directive

app.controller 'createController', ($location, $rootScope, Event, Upload) ->

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
      $location.url "/event/#{ createdEvent.id }"
      return
    return

  resetEvent()
  return
