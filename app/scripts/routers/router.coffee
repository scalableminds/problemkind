### define 
app : app
backbone : Backbone
###
class RouterRouter extends Backbone.Router

  routes : 

    "" : "index"


  index : ->

    app.view.renderSubview(
      new app.views.ProblemFormView(
        model : app.models.Problem.create()
      )
      ".content"
    )
    app.view.renderSubview(
      new app.views.ProblemOverviewView(
        model : new Backbone.Model(title : "WAT")
        collection : app.models.Problem.trending()
      )
      ".content"
    )


