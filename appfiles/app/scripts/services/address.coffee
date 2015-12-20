'use strict'

angular.module('downespace').service 'Address', ($q) ->
  geocoder = new google.maps.Geocoder()

  this.getCoords = (address) ->
    deferred = $q.defer()
    geocoder.geocode 'address': address, (results, status) ->
      deferred.resolve results
      return
    return deferred.promise

  return
