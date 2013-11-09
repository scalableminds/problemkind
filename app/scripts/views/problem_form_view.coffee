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

    @activeAnswerInput = new ProblemFormView.InputView(model : new app.models.Answer())
    @renderSubview(@activeAnswerInput, ".answers")


  handleNextButton : ->

    @model.addAnswer(@activeAnswerInput.model)

    @activeAnswerInput = new ProblemFormView.InputView(model : new app.models.Answer())
    @renderSubview(@activeAnswerInput, ".answers")

    @$el.removeClass("before-wish")


  handleLollipopButton : ->

    @model.addAnswer(@activeAnswerInput.model)
    @model.save()

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
