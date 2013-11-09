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


  handleCollectionSync : (item) ->

    @collection.trigger("add", item)
    return


  class @ItemView extends HumanView

    textBindings :
      "thumbs" : ".problem-statement"

    template : templates.problem_overview_item

    render : ->

      @renderAndBind() 