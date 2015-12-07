'use strict'

DATE_FORMAT = 'ddd, MMM D, h:mm A'

angular.module('downespace').service 'Date', ->
  service = {}

  service.toTimestamp = (momentObject) ->
    return momentObject.utc().unix()

  service.toDateString = (timestamp) ->
    return moment.unix(timestamp).format(DATE_FORMAT)

  return service
