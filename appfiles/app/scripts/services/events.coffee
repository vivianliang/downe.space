'use strict'

angular.module('appfilesApp').service 'Event', ($http) ->
  service = {}

  service.get = (eventId) ->
    return $http.get("/api/event/#{ eventId }/").then ({data}) -> data

  # service.follow = (goalId, followers...) ->
  #   return $http.post "/api/goals/#{ goalId }/follow/", {followers: followers}

  # service.unfollow = (goalId, unfollowers...) ->
  #   return $http.post "/api/goals/#{ goalId }/unfollow/", {unfollowers: unfollowers}

  return service
