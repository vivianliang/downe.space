'use strict'

angular.module('downespace').service 'Event', ($http) ->
  service = {}

  service.getEvents = ->
    return $http.get("/api/events/").then ({data}) -> data

  service.getEvent = (eventId) ->
    return $http.get("/api/event/#{ eventId }/").then ({data}) -> data

  return service
