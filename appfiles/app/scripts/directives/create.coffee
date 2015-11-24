'use strict'

angular.module('downespace').directive 'create', ->
  directive =
    controller  : 'createController'
    controllerAs: 'create'
    restrict    : 'E'
    templateUrl : 'views/directives/create.html'
  return directive

angular.module('downespace').controller 'createController', ($rootScope, Event) ->

  resetEvent = =>
    this.newEvent = {}
    return

  this.createEvent = =>
    Event.create(this.newEvent).then (createdEvent) ->
      resetEvent()
      return
    return

  resetEvent()
  return
