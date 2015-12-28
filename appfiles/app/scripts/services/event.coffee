'use strict'

angular.module('downespace').service 'Event', ($http, Date) ->
  service = {}

  service.processEvent = (rawEvent) ->
    event       = angular.copy rawEvent
    event.start = Date.toDateString event.start
    event.end   = Date.toDateString event.end
    return event

  service.processEvents = (rawEvents) ->
    return _.map rawEvents, service.processEvent

  service.create = (event) ->
    console.log event
    newEvent = angular.copy event
    # TODO: remove these if-checks once frontend form validation is added
    if newEvent.start
      newEvent.start = Date.toTimestamp newEvent.start
    if newEvent.end
      newEvent.end = Date.toTimestamp newEvent.end
    return $http.post('/api/events/', newEvent).then ({data}) -> data

  service.addPicture = (pictureFile) ->
    return $http.put('/api/events/', pictureFile).then ({data}) -> data

  service.getEvents = (page=1, filters) ->
    params = _.merge page: page, filters
    return $http.get('/api/events/', params: params).then ({data}) ->
      data.events = service.processEvents data.events
      return data

  service.getEvent = (eventId) ->
    return $http.get("/api/event/#{ eventId }/").then ({data}) -> service.processEvent data

  service.edit = (event) ->
    newEvent = angular.copy event
    # TODO: remove these if-checks once frontend form validation is added
    if newEvent.start
      newEvent.start = Date.toTimestamp newEvent.start
    if newEvent.end
      newEvent.end = Date.toTimestamp newEvent.end
    return $http.put("/api/event/#{ newEvent.id }/", newEvent).then ({data}) -> data

  return service
