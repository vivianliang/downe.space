'use strict'

angular.module('downespace').service 'Event', ($http, Date) ->
  service = {}

  service.create = (event) ->
    newEvent = angular.copy event
    if newEvent.start
      newEvent.start = Date.toTimestamp newEvent.start
    if newEvent.end
      newEvent.end = Date.toTimestamp newEvent.end
    return $http.post('/api/event/', newEvent).then ({data}) -> data

  service.getEvents = (page=1) ->
    params = page: page
    return $http.get('/api/events/', params: params).then ({data}) ->
      for e in data.events
        if e.start?
          e.start = moment(e.start).format()
        if e.end?
          e.end = moment(e.end).format()
      return data

  service.getEvent = (eventId) ->
    return $http.get("/api/event/#{ eventId }/").then ({data}) -> data

  return service
