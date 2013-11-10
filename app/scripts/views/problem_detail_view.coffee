### define
app : app
human_view : HumanView
backbone : Backbone
underscore : _
templates : templates
###

proxyModel = (source) ->

  model = new Backbone.Model()

  model.listenTo(source, "all", (eventKey) ->
    if (match = eventKey.match(/change:(.*)/))
      key = match[1]
      @set(key, source.get(key))
  )
  model.set(source.toJSON())
  model

proxyModel = _.memoize(proxyModel, (model) -> model.id)


class ProblemDetailView extends HumanView

  template : templates.problem_detail

  render : ->

    @renderAndBind()

    answerCollection = new Backbone.Collection()
    @listenToAndRun(@model, "change:answers", ->
      @model.fetchAnswers()
      answerCollection.reset()
      @model.get("answers").forEach( (answer) -> answerCollection.add(proxyModel(answer)) ) 
    )

    @renderSubview(new ProblemDetailView.AnswerListView(collection : answerCollection), @$(".questions"))
    @renderSubview(new ProblemDetailView.SolutionView(model : @model), @$(".solutions"))


  class @SolutionView extends HumanView

    template : templates.problem_detail_solution

    render : ->
      @renderAndBind()


  class @AnswerListView extends HumanView

    template : templates.problem_detail_answer_list

    render : ->

      @renderAndBind()
      @renderCollection(@collection, ProblemDetailView.AnswerView, @el)



  class @AnswerView extends HumanView

    textBindings :
      "answer" : ".answer"
      "question" : ".question"

    template : templates.problem_detail_answer

    render : ->

      @renderAndBind()
