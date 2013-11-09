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
    human_view:
      deps: [
        'backbone'
        'underscore'
      ]
      exports: 'HumanView'
  paths:
    async: '../bower_components/async/lib/async'
    jquery: '../bower_components/jquery/jquery'
    backbone: '../bower_components/backbone/backbone'
    underscore: '../bower_components/lodash/dist/lodash'
    bootstrap: '../bower_components/bootstrap/dist/js/bootstrap'
    parse: 'lib/parse-1.2.12'
    human_view: '../bower_components/human_view/human-view'

define("app", ["lib/application"], (Application) -> new Application())

define([
    'backbone'
    'jquery'
    'app'
    'parse'
    'routers/router'
    'models'
    'views'
  ], (Backbone, $, app, Parse, Router) ->

    window.app = app

    app.addInitializer( (options, callback) -> 
      $(-> callback())
      return
    )

    app.addInitializer( -> 
      Parse.initialize("Ho021rHvrqJ8QsiDFJi9VVFvcdYj0Q4qKV9BnbHz", "TJpqaB1DKdcfgPUfHZE12whZmWTQmiJVRdP8K0HI")
      return
    )

    app.addInitializer( ->
      app.router = new Router()
    )

    app.on("start", ->

      app.view = new app.views.MainView().renderAndBind()
      $("body").append(app.view.el)

      Backbone.history.start()

      return
    )
    
    app.start()
)