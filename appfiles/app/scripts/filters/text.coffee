
'use strict'

app = angular.module 'downespace'

app.filter 'newLines', ->
  return (data) ->
    if not data
      return data
    return data.replace /\n\r?/g, '<br>'
