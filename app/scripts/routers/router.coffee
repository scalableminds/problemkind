### define 
app : app
backbone : Backbone
###
class RouterRouter extends Backbone.Router

  routes : 

    "" : "index"
    "problem/:problem_id" : "problem_detail"


  index : ->

    @changeView(
      new app.views.ProblemFormView(
        model : app.models.Problem.create()
      )
      new app.views.ProblemOverviewView(
        model : new Backbone.Model(title : "Trending Problems")
        collection : app.models.Problem.trending()
      )
    )



  problem_detail : (problemId) ->

    @changeView(
      new app.views.ProblemDetailView()
    )


  changeView : (views...) ->

    if @currentViews
      _(@currentViews).invoke("remove")

    @currentViews = views

    _(@currentViews).each( (view) ->
      app.view.renderSubview(view, ".content")
    )