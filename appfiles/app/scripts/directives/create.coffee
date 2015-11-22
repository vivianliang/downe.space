'use strict'

angular.module('downespace').directive 'create', ->
  directive =
    controller  : 'createController'
    controllerAs: 'create'
    restrict    : 'E'
    templateUrl : 'views/directives/create.html'
  return directive

angular.module('downespace').controller 'createController', ($rootScope, Event) ->

  this.newEvent = {}
  resetEvent = =>
    this.newEvent =
      start: moment().startOf('day').toDate()
      end: 1
      #end  : moment().endOf('day').seconds(0).milliseconds(0).toDate()
    console.log this.newEvent.start
    console.log this.newEvent.end
    return

  this.createEvent = =>
    Event.create(this.newEvent).then (createdEvent) ->
      #resetEvent()
      return
    return


  this.test = =>
    this.newEvent =
      start: new Date()
      end: new Date()


  resetEvent()
  return
