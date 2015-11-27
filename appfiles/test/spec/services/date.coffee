'use strict'

describe 'Service: Date', ->

  beforeEach ->
    module 'downespace'
    inject (Date) ->
      this.Date = Date
      return

    this.testDate   = moment '2015-01-01T00:00:00-08:00'
    this.timestamp  = this.testDate.clone().unix()
    this.dateString = this.testDate.clone().format 'MM/DD/YYYY hh:mm A'
    return

  it 'should convert a moment to a unix timestamp', ->
    expect(this.Date.toTimestamp(this.testDate)).toEqual this.timestamp
    return

  it 'should convert a unix timestamp to a moment', ->
    expect(this.Date.toDateString(this.timestamp)).toEqual this.dateString
    return
  return
