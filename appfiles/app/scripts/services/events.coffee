'use strict'

angular.module('appfilesApp').service 'Event', ($http) ->
  service = {}

  service.get = (eventId) ->
    return $http.get("/api/event/#{ eventId }/").then ({data}) -> data

  return service
