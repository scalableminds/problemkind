### define
human_view : HumanView
underscore : _
templates : templates
###

class ProblemOverviewView extends HumanView

  template : templates.problem_overview

  textBindings : 
    "title" : "h3"

  render : ->

    @renderAndBind()
    @$container = @$(".row")
    @renderCollection(@collection, ProblemOverviewView.ItemView, @$container[0])
    @listenTo(@collection, "sync", @handleCollectionSync)


  handleCollectionSync : ->

    console.log(arguments)
    @collection.each( (item) => @collection.trigger("add", item) )
    return


  class @ItemView extends HumanView

    textBindings : 
      "_answer0" : ".problem-statement"
      "_answer1" : ".problem-question"

    template : templates.problem_overview_item

    render : ->

      @renderAndBind()
      @model.fetchAnswers()