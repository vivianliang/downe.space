'use strict'

karmaConfig = require './karma.conf.coffee'

module.exports = (config) ->
  karmaConfig(config)

  config.set
    reporters: ['progress', 'junit']

    junitReporter:
      outputDir: process.env.CIRCLE_TEST_REPORTS + '/angular/',
      outputFile: 'results.xml'
