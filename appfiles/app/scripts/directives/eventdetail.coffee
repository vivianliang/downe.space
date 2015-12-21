'use strict'

angular.module('downespace').directive 'eventDetail', ->
  directive =
    controller  : 'eventDetailController'
    controllerAs: 'eventDetail'
    restrict    : 'E'
    templateUrl : 'views/directives/eventdetail.html'
  return directive

angular.module('downespace').controller 'eventDetailController', (Event, $routeParams) ->
  this.eventId = $routeParams.id
  this.event   = null

  this.getEvent = =>
    Event.getEvent(this.eventId).then (eventData) =>
      this.event = eventData
      return
    return

  this.getEvent()

  this.addToCalendar = ->
    # TODO
    return

  this.editEvent = ->
    Event.edit(id: this.eventId, name: 'rwc starbucks', description: 'some test desc')
    return

  return
