'use strict'

angular.module('downespace').service 'Event', ($http) ->
  service = {}

  service.getEvents = (page=1) ->
    params = page: page
    return $http.get('/api/events/', params: params).then ({data}) -> data

  service.getEvent = (eventId) ->
    return $http.get("/api/event/#{ eventId }/").then ({data}) -> data

  return service
