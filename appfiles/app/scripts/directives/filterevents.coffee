'use strict'

angular.module('downespace').directive 'filterEvents', ->
  directive =
    controller  : 'filterEventsController'
    controllerAs: 'filterEvents'
    restrict    : 'E'
    templateUrl : 'views/directives/filterevents.html'
  return directive

angular.module('downespace').controller 'filterEventsController', (Event) ->

  this.expanded = false

  this.toggle = =>
    this.expanded = not this.expanded
    return

  return
