'use strict'

DATE_FORMAT = 'MM/DD/YYYY hh:mm A'

angular.module('downespace').directive 'dateTimePicker', ->
  directive =
    restrict : 'A'
    scope    :
      ngModel: '='

    link: (scope, element, attrs) ->
      element.datetimepicker({useCurrent: true, sideBySide: true, format: DATE_FORMAT})

      element.on 'dp.change', ->
        scope.ngModel = element.data('DateTimePicker').date().format(DATE_FORMAT)
        return
      return
  return directive
