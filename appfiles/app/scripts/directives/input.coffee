'use strict'

angular.module('downespace').directive 'input', ->
  directive =
    restrict: 'E'
    require : '?ngModel'

    link: (scope, element, attrs, ngModel) ->
      # only override default input directive for our custom type
      if attrs.type isnt 'ds-datetime'
        return

      # initialize the date time picker
      element.datetimepicker {useCurrent: true, sideBySide: true}

      # when the internal date object is set, set the ng-model as well
      element.on 'dp.change', (event) ->
        if event.date
          # create a new moment without timezone information to convert to users local time
          ngModel.$setViewValue moment(event.date.format('YYYY-MM-DD HH:mm'))
        return

      # when the ng-model value is reset, we need to reset the interal date object as well
      scope.$watch (-> ngModel.$modelValue), (newModelValue) ->
        if not newModelValue and element.data('DateTimePicker').date()
          element.data('DateTimePicker').date(null)
        return

      return
  return directive
