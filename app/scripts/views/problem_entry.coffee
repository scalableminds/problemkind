### define
human_view : HumanView
underscore : _
templates : templates
###

class ProblemEntry extends HumanView

	events : 
		"click .lollipop-button" : "handleLollipopButton"
		"click .next-button" : "handleNextButton"

	render : ->

		@$el.html(templates.test)