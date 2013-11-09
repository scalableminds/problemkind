### define
app : app
human_view : HumanView
underscore : _
templates : templates
###

class ProblemFormView extends HumanView

  template : templates.problem_form

  events : 
    "click .lollipop-button" : "handleLollipopButton"
    "click .next-button" : "handleNextButton"

  render : ->

    @renderAndBind()

    @activeAnswerInput = new ProblemFormView.InputView(model : app.models.Answer.create())
    @renderSubview(@activeAnswerInput, ".answers")


  handleNextButton : ->

    @model.addAnswer(@activeAnswerInput.model)

    @activeAnswerInput = new ProblemFormView.InputView(model : app.models.Answer.create())
    @renderSubview(@activeAnswerInput, ".answers")

    @$el.removeClass("before-wish")


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




  class @InputView extends HumanView

    template : templates.problem_form_input

    events : 
      'change .problem-statement-input' : 'handleInputChange'


    handleInputChange : ->
      @model.set("content", @$(".problem-statement-input").val())
      return


    render : -> 
      @renderAndBind()
