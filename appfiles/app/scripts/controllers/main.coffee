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

  $scope.events   = []
  $scope.nextPage = 1
  $scope.more     = true

  $scope.getEvents = ->
    Event.getEvents($scope.nextPage).then (eventData) ->
      $scope.events.push eventData.events...
      $scope.more = eventData.more
      if $scope.more
        $scope.nextPage = eventData.page + 1
      return
    return

  return
