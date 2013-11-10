### define 
app : app
backbone : Backbone
###
class RouterRouter extends Backbone.Router

  routes : 

    "" : "index"
    "submitted" : "submitted"
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


  submitted : ->

    @changeView(
      new app.views.ProblemFormView.ResultView()
      new app.views.ProblemOverviewView(
        model : new Backbone.Model(title : "Trending Problems")
        collection : app.models.Problem.trending()
      )
    )


  problem_detail : (problemId) ->

    problem = new app.models.Problem(id : problemId)
    problem.fetch()
    @changeView(
      new app.views.ProblemDetailView(
        model : problem
      )
    )


  changeView : (views...) ->

    if @currentViews
      _(@currentViews).invoke("remove")

    @currentViews = views

    _(@currentViews).each( (view) ->
      app.view.renderSubview(view, ".content")
    )