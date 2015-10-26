'use strict'

###*
 # @ngdoc function
 # @name appfilesApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the appfilesApp
###
app = angular.module 'appfilesApp'

app.controller 'MainCtrl', ($scope, Event) ->

  @awesomeThings = [
    'HTML5 Boilerplate'
    'AngularJS'
    'Karma'
  ]
  $scope.getEvent = ->
    promise = Event.get 1
    promise.then (events) ->
      $scope.events = events
      return

  promise = Event.get 1
  promise.then (events) ->
    $scope.events = events
    return


  return
