'use strict'

angular.module('downespace').service 'Events', ($http) ->
  service = {}

  service.get = ->
    return $http.get("/api/events/").then ({data}) -> data

  service.getEvent = (eventId) ->
    return $http.get("/api/events/#{ eventId }/").then ({data}) -> data

  return service
