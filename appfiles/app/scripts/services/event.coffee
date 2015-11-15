'use strict'

angular.module('downespace').service 'Event', ($http) ->
  service = {}

  service.create = (newEvent) ->
    response = $http.post '/api/event/', newEvent
    return response.then ({data}) -> data

  service.getEvents = (page=1) ->
    params = page: page
    return $http.get('/api/events/', params: params).then ({data}) ->
      for e in data.events
        if e.start?
          e.start = moment(e.start).format('LLLL')
        if e.end?
          e.end = moment(e.end).format('LLLL')
      return data

  service.getEvent = (eventId) ->
    return $http.get("/api/event/#{ eventId }/").then ({data}) -> data

  return service
