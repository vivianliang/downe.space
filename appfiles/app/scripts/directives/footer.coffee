'use strict'

angular.module('downespace').directive 'footer', ->
  directive =
    controller  : 'topBarController'
    controllerAs: 'topBar'
    restrict    : 'E'
    templateUrl : 'views/directives/footer.html'
  return directive

angular.module('downespace').controller 'footer', ->
  return
