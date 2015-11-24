'use strict'

angular.module('downespace').directive 'footer', ->
  directive =
    restrict    : 'E'
    templateUrl : 'views/directives/footer.html'
  return directive
