### define
app : app
human_view : HumanView
underscore : _
templates : templates
###

class ProblemDetailView extends HumanView

  template : templates.problem_detail


  render : ->

    @renderAndBind()
