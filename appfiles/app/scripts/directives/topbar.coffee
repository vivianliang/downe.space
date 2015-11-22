'use strict'

angular.module('downespace').directive 'topBar', ->
  directive =
    controller  : 'topBarController'
    controllerAs: 'topBar'
    restrict    : 'E'
    templateUrl : 'views/directives/topbar.html'
  return directive

angular.module('downespace').controller 'topBarController', ->
  return
