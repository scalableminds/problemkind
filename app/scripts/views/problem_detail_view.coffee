### define
app : app
human_view : HumanView
backbone : Backbone
underscore : _
templates : templates
###

class ProblemDetailView extends HumanView

  template : templates.problem_detail


  render : ->

    @renderAndBind()

    answerCollection = new Backbone.Collection()

    @renderCollection(answerCollection, ProblemDetailView.ItemView, @$(".questions"))

    @listenToAndRun(@model, "change:answers", ->
      @model.fetchAnswers()
      answerCollection.reset()
      @model.get("answers").forEach( (answer) => answerCollection.add(@proxyModel(answer)) ) 
    )


  proxyModel : (source) ->

    model = new Backbone.Model()

    model.listenTo(source, "all", (eventKey) ->
      if (match = eventKey.match(/change:(.*)/))
        key = match[1]
        @set(key, source.get(key))
    )
    model.set(source.toJSON())
    model


  class @ItemView extends HumanView

    textBindings :
      "content" : ".answer"

    template : templates.problem_detail_item

    render : ->

      @renderAndBind()
