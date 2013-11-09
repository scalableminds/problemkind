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
    bootstrap:
      deps: ['jquery']
      exports: 'jquery'
  paths:
    async: '../bower_components/async/lib/async'
    jquery: '../bower_components/jquery/jquery'
    backbone: '../bower_components/backbone/backbone'
    underscore: '../bower_components/lodash/dist/lodash'
    bootstrap: '../bower_components/bootstrap/dist/js/bootstrap'

define("app", ["lib/application"], (Application) -> new Application())

define([
    'backbone'
    'jquery'
    'app'
    'routers/router'
  ], (Backbone, $, app) ->
    Backbone.history.start()

    app.addInitializer( (options, callback) -> 
      $(-> callback())
      return
    )

    app.start()
)