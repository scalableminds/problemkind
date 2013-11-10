### define
human_view : HumanView
underscore : _
templates : templates
###

class MainView extends HumanView

  template : templates.main

  @capitalize : (string) ->
    string.charAt(0).toUpperCase() + string.slice(1)

  render : -> 
    @renderAndBind()

    displayName = app.models.User.maybeUser(( (user) -> MainView.capitalize(user.get("username"))), "Maik")

    @$(".user-name").text(displayName)
