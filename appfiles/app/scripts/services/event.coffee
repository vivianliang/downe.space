'use strict'

angular.module('downespace').service 'Event', ($http, Date) ->
  service = {}

  service.processEvent = (rawEvent) ->
    event       = angular.copy rawEvent
    event.start = Date.toDateString event.start
    event.end   = Date.toDateString event.end
    return event

  service.create = (event) ->
    newEvent = angular.copy event
    # TODO: remove these if-checks once frontend form validation is added
    if newEvent.start
      newEvent.start = Date.toTimestamp newEvent.start
    if newEvent.end
      newEvent.end = Date.toTimestamp newEvent.end
    return $http.post('/api/event/', newEvent).then ({data}) -> data

  service.getEvents = (page=1) ->
    params = page: page
    return $http.get('/api/events/', params: params).then ({data}) ->
      data.events = _.map(data.events, service.processEvent)
      return data

  service.getEvent = (eventId) ->
    return $http.get("/api/event/#{ eventId }/").then ({data}) -> service.processEvent data

  return service
