'use strict'

###*
 # @ngdoc function
 # @name downespace.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the downespace
###
app = angular.module 'downespace'

app.controller 'MainCtrl', ($scope, Event) ->

  @awesomeThings = [
    'HTML5 Boilerplate'
    'AngularJS'
    'Karma'
  ]

  $scope.getEvents = ->
    Event.getEvents().then (events) ->
      $scope.events = events
      return
    return

  return
