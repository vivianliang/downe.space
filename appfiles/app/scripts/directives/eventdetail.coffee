'use strict'

angular.module('downespace').directive 'eventDetail', ->
  directive =
    controller  : 'eventDetailController'
    controllerAs: 'eventDetail'
    restrict    : 'E'
    templateUrl : 'views/directives/eventdetail.html'
  return directive

angular.module('downespace').controller 'eventDetailController', (Event) ->
  console.log 'event detail controller'
  return
