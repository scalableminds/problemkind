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
    @$container = @$(".row.problem-tiles")
    @renderCollection(@collection, ProblemOverviewView.ItemView, @$container[0])
    @listenTo(@collection, "sync", @handleCollectionSync)


  handleCollectionSync : ->

    console.log(arguments)
    @collection.each( (item) => @collection.trigger("add", item) )
    return


  class @ItemView extends HumanView

    events : 
      "click .thumb-info" : "handleThumbClick"

    textBindings : 
      "_answer0" : ".problem-statement"
      "_answer1" : ".problem-question"

    template : templates.problem_overview_item

    render : ->

      @renderAndBind()

      @$("a").attr("href", "#problem/#{@model.id}")
      
      @listenToAndRun(@model, "change:thumbs", ->
        @$(".thumb-count").text(@model.countThumbs())
        @$(".thumb-info").toggleClass("thumbed", not @model.canGiveThumbs())
      )
      @model.fetchAnswers()



    handleThumbClick : (event) ->

      event.preventDefault()
      event.stopPropagation()

      if @model.canGiveThumbs()
        @model.thumbsUp()
      else
        @model.thumbsDown()


        