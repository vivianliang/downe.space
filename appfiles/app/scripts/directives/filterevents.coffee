'use strict'

angular.module('downespace').directive 'filterEvents', ->
  directive =
    controller  : 'filterEventsController'
    controllerAs: 'filterEvents'
    require     : '^eventList'
    restrict    : 'E'
    templateUrl : 'views/directives/filterevents.html'
    link        : (scope, element, attrs, eventList) ->
      scope.eventList = eventList
      return
  return directive

angular.module('downespace').controller 'filterEventsController',
  ($location, $scope, Event, Address) ->
    this.eventList       = $scope.eventList
    this.filters         = {}
    this.expanded        = false
    # debounce 500ms unless blur (lose focus), then update immediately
    this.locationOptions = updateOn: 'default blur', debounce: {default: 500, blur: 0}

    this.toggle = =>
      this.expanded = not this.expanded
      return

    this.parseParams = =>
      validParams = ['location', 'range']
      params = $location.search()

      for key, value of params
        if key not in validParams
          continue

        # show filter bar by default if search is being populated by url params
        if not this.expended
          this.expanded = true

        # location requires extra logic (external api call), so handle special
        if key is 'location'
          this.location = value
        else
          this.filters[key] = value
      return

    this.setParams = =>
      if this.location
        $location.search 'location', this.location
      if this.filters.range
        $location.search 'range', this.filters.range
      return

    this.submitNewFilters = =>
      submit = =>
        this.eventList.resetEvents()
        this.setParams()
        this.eventList.filters = this.filters
        this.eventList.getEvents()
        return

      watch = $scope.$watch (=> this.coordPromise), (promise) ->
        # if coordPromise has 'then' function, wait for promise to resolve
        if typeof promise?.then is 'function'
          promise.then ->
            submit()
            return
        # otherwise, no promise waiting for coords is present
        else
          submit()
        # deregister watch as we only want this to run once per call
        watch()
        return
      return

    $scope.$watch (=> this.location), (location) =>
      if location
        this.coordPromise = Address.getCoords(location).then (results) =>
          result                = results[0]
          this.formattedAddress = result.formatted_address
          this.filters.lat      = result.geometry.location.lat()
          this.filters.lon      = result.geometry.location.lng()
          return
      else
        delete this.formattedAddress
        delete this.filters.lat
        delete this.filters.lon
      return

    $scope.$watch (=> this.filters), (filters) ->
      for key, value of filters
        if not value
          delete filters[key]
      return
    , true

    this.parseParams()
    this.submitNewFilters()
    return
