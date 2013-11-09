# global require
'use strict'

require.config
  shim:
    underscore:
      exports: '_'
    backbone:
      deps: [
        'underscore'
        'jquery'
      ]
      exports: 'Backbone'
    parse:
      deps: [
        'underscore'
        'jquery'
      ]
      exports: 'Parse'
    bootstrap:
      deps: ['jquery']
      exports: 'jquery'
  paths:
    async: '../bower_components/async/lib/async'
    jquery: '../bower_components/jquery/jquery'
    backbone: '../bower_components/backbone/backbone'
    underscore: '../bower_components/lodash/dist/lodash'
    bootstrap: '../bower_components/bootstrap/dist/js/bootstrap'
    parse: 'lib/parse-1.2.12'

define("app", ["lib/application"], (Application) -> new Application())

define([
    'backbone'
    'jquery'
    'app'
    'parse'
    'models'
    'routers/router'
  ], (Backbone, $, app, Parse) ->
    Backbone.history.start()

    app.addInitializer( (options, callback) -> 
      $(-> callback())
      return
    )

    app.addInitializer( -> 
      Parse.initialize("Ho021rHvrqJ8QsiDFJi9VVFvcdYj0Q4qKV9BnbHz", "TJpqaB1DKdcfgPUfHZE12whZmWTQmiJVRdP8K0HI")
      return
    )

    window.app = app

    app.start()
)