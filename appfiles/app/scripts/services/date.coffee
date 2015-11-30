'use strict'

DATE_FORMAT = 'ddd, MMM D, H:m A'

angular.module('downespace').service 'Date', ->
  service = {}

  service.toTimestamp = (momentObject) ->
    return momentObject.utc().unix()

  service.toDateString = (timestamp) ->
    return moment.unix(timestamp).format(DATE_FORMAT)

  return service
