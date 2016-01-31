'use strict'

describe 'Filter: text', ->

  beforeEach ->
    module 'downespace'

    inject ($filter)  ->
      this.newLines = $filter 'newLines'

  it 'should render newlines', ->
    text = 'hello\nworld\n'
    expect(this.newLines(text)).toBe 'hello<br>world<br>'
