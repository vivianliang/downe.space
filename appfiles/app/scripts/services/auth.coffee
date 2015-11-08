'use strict'

angular.module('appfilesApp').service 'Auth', ($http) ->
  service = {}

  service.getUser = ->
    return $http.get('/api/auth/').then ({data}) -> data

  return service
