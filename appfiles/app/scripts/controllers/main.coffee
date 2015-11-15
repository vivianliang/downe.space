'use strict'

###*
 # @ngdoc function
 # @name downespace.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the downespace
###
app = angular.module 'downespace'

app.controller 'MainCtrl', ($scope, Events) ->

  @awesomeThings = [
    'HTML5 Boilerplate'
    'AngularJS'
    'Karma'
  ]

  $scope.getEvents = ->
    promise = Events.get()
    promise.then (events) ->
      $scope.events = events
      return

  return
