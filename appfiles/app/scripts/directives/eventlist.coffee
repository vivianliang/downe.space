'use strict'

angular.module('downespace').directive 'eventList', ->
  directive =
    controller  : 'eventListController'
    controllerAs: 'eventList'
    restrict    : 'E'
    templateUrl : 'views/directives/eventlist.html'
  return directive

angular.module('downespace').controller 'eventListController', (Event) ->

  this.resetEvents = =>
    this.events   = []
    this.nextPage = 1
    this.more     = true
    this.gridView = true
    this.filters  = {}
    return

  this.loading = this.nextPage == 0
  this.getEvents = =>
    if this.loading
      return
    # this.loading = this.nextPage == 0
    Event.getEvents(this.nextPage, this.filters)
      .then (eventData) =>
        this.events.push eventData.events...
        this.more = eventData.more
        if this.more
          this.nextPage = eventData.page + 1
        return
      .finally => this.loading = false
    return

  return
