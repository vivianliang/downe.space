'use strict'

angular.module('downespace').service 'Event', ($http) ->
  service = {}

  service.get = (eventId) ->
    return $http.get("/api/event/#{ eventId }/").then ({data}) -> data

  return service
