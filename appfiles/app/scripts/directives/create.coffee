'use strict'

angular.module('downespace').directive 'create', ->
  directive =
    controller  : 'createController'
    controllerAs: 'create'
    restrict    : 'E'
    templateUrl : 'views/directives/create.html'
  return directive

angular.module('downespace').controller 'createController', ($rootScope, Event) ->

  this.resetEvent = =>
    this.newEvent =
      start: moment().startOf('day').toDate()
      end  : moment().endOf('day').seconds(0).milliseconds(0).toDate()
    return

  this.createEvent = =>
    Event.create(this.newEvent).then (createdEvent) =>
      this.resetEvent()
      return
    return

  this.resetEvent()
  return
