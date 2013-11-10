### define
app : app
human_view : HumanView
backbone : Backbone
underscore : _
templates : templates
###

proxyModel = (source) ->

  model = new Backbone.Model(
    answers : []
  )

  model.fetchAnswers = (args...) -> app.models.Answer::fetchAnswers.apply(this, args)

  model.addAnswer = (answer) ->
    answer.save()
    newAnswers = source.get("answers").concat([answer])
    source.set("answers", newAnswers)
    source.save()

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

    if @model.id == "AeT2daeHMZ"
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

    events : 
      "click .ask-button" : "handleAskButton"
      'input .question-input' : 'handleInput'
      "click .next-button" : "handleNextButton"

    template : templates.problem_detail_answer

    render : ->

      @renderAndBind()

      id = _.uniqueId("answer-view")
      @$(".sub-questions").attr("id", id)
      @$(".ask-button").attr("href", "##{id}")

      answerCollection = new Backbone.Collection()
      @listenToAndRun(@model, "change:answers", ->
        @model.fetchAnswers()
        answerCollection.reset()
        @model.get("answers").forEach( (answer) -> answerCollection.add(proxyModel(answer)) ) 

        if @model.get("answers").length
          @$(".question-count").text("/ Read #{@model.get("answers").length} question#{if @model.get("answers").length > 1 then "s" else ""}")
        else
          @$(".question-count").empty()
      )

      @renderSubview(new ProblemDetailView.AnswerListView(collection : answerCollection), @$(".questions-list"))

      @activeSubAnswer = app.models.Answer.create()


    handleAskButton : ->

      @$(".ask-button").toggleClass("active")

      if @$(".ask-button").hasClass("active")
        @$(".question-input")[0].focus()


    handleInput : ->

      charCount = @$(".question-input").val().length
      @$(".char-counter").text("#{charCount}/140")
      if charCount > 140
        @$(".char-counter").addClass("warning")
      else
        @$(".char-counter").removeClass("warning")


    handleNextButton : ->

      $input = @$(".question-input").last()
      if $input.val()
        @activeSubAnswer.set("question", $input.val())
        @model.addAnswer(@activeSubAnswer)

        @activeSubAnswer = app.models.Answer.create()
        $input.val("")



