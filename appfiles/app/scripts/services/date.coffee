'use strict'

DATE_FORMAT = 'MM/DD/YYYY hh:mm A'

angular.module('downespace').service 'Date', ->
  service = {}

  service.toTimestamp = (momentObject) ->
    return momentObject.utc().unix()

  service.toDateString = (timestamp) ->
    return moment(timestamp).format(DATE_FORMAT)

  return service
