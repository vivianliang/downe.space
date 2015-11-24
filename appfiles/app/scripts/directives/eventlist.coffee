'use strict'

angular.module('downespace').directive 'eventList', ->
  directive =
    controller  : 'eventListController'
    controllerAs: 'eventList'
    restrict    : 'E'
    templateUrl : 'views/directives/eventlist.html'
  return directive

angular.module('downespace').controller 'eventListController', (Event) ->

  this.events   = []
  this.nextPage = 1
  this.more     = true
  this.gridView = true

  this.getEvents = =>
    Event.getEvents(this.nextPage).then (eventData) =>
      this.events.push eventData.events...
      this.more = eventData.more
      if this.more
        this.nextPage = eventData.page + 1
      return
    return

  this.getEvents()

  this.saveEvent = (eventId) ->
    return

  return
