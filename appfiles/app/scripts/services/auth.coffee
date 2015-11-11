'use strict'

angular.module('downespace').service 'Auth', ($http) ->
  service = {}

  service.getUser = ->
    return $http.get('/api/auth/').then ({data}) ->
      if data.is_authenticated
        return data
      return null

  return service
