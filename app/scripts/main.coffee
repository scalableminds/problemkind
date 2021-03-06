# global require
'use strict'

require.config(

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
    human_view: '../bower_components/human_view/human-view'
    parse: 'lib/parse-1.2.12'
)

require.onError = console.error.bind(console)

define("app", ["lib/application"], (Application) -> new Application())

require([
    'backbone'
    'jquery'
    'app'
    'parse'
    'routers/router'
    'models'
    'views'
    'bootstrap'
  ], (Backbone, $, app, Parse, Router, Models, Views, Bootstrap) ->

    window.app = app

    app.addInitializer( (options, callback) -> 
      $(-> callback())
      return
    )

    app.addInitializer( -> 
      Parse.initialize("Ho021rHvrqJ8QsiDFJi9VVFvcdYj0Q4qKV9BnbHz", "TJpqaB1DKdcfgPUfHZE12whZmWTQmiJVRdP8K0HI")
      Parse.User.logIn("maik", ":D",
        success: (user) ->
          console.log("Logged in as #{user.get("username")}")

        error: (user, error) ->
          console.error("Couldn't log in #{error}")
      )
      return
    )

    app.addInitializer( ->
      app.router = new Router()
      app.views = Views
      app.models = Models
    )

    app.on("start", ->

      app.view = new app.views.MainView()
      app.view.render()
      $("body").append(app.view.el)

      Backbone.history.start()

      return
    )
    
    app.start()
)