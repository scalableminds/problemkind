### define
app : app
backbone : Backbone
human_view : HumanView
underscore : _
templates : templates
###

class ProblemFormView extends HumanView

  template : templates.problem_form

  events : 
    "click .lollipop-button" : "handleLollipopButton"
    "click .next-button" : "handleNextButton"
    "submit form" : "handleNextButton"

  render : ->

    @renderAndBind()

    @activeAnswerInput = new ProblemFormView.InputView(model : app.models.Answer.create())
    @renderSubview(@activeAnswerInput, ".answers-input")


  handleNextButton : ->

    if @activeAnswerInput.model.get("content")
      @model.addAnswer(@activeAnswerInput.model)
      @activeAnswerInput.remove()

      @renderSubview(
        new ProblemFormView.DisplayView(
          model : new Backbone.Model(
            question : 'Why?'
            answer : @activeAnswerInput.model.get("content")
          )
        )
        ".answers-complete"
      )

      @activeAnswerInput = new ProblemFormView.InputView(model : app.models.Answer.create())
      @renderSubview(@activeAnswerInput, ".answers-input")

      @$el.removeClass("before-wish")
      @$(".big-question").text("Why?")


  handleLollipopButton : ->

    if @activeAnswerInput.model.get("content") != ""
      @model.addAnswer(@activeAnswerInput.model)
    else
      @activeAnswerInput.model.destroy()

    @model.complete()

    @animateRemove()


  animateRemove : ->

    @$el.addClass("fade")
    @$el.one("transitionend", => @remove())



  class @DisplayView extends HumanView

    textBindings :
      'question' : '.question'
      'answer' : '.answer'

    template : templates.problem_form_display

    render : ->

      @renderAndBind()
      @$el.addClass("fade")
      _.defer => @$el.addClass("in")


  class @InputView extends HumanView

    template : templates.problem_form_input

    events : 
      'change .problem-statement-input' : 'handleInputChange'
      'input .problem-statement-input' : 'handleInput'


    handleInputChange : ->
      @model.set("content", @$(".problem-statement-input").val())
      return


    handleInput : ->

      charCount = @$(".problem-statement-input").val().length
      @$(".char-counter").text("#{charCount}/140")
      if charCount > 140
        @$(".char-counter").addClass("warning")
      else
        @$(".char-counter").removeClass("warning")


    setFocus : ->

      @$(".problem-statement-input")[0].focus()


    render : -> 

      @renderAndBind()
      _.defer => @setFocus()
