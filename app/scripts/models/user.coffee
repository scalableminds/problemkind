### define
parse: Parse
###

class User
  @withUser : (f) ->
    currentUser = Parse.User.current()
    if currentUser
      f(currentUser)
    else 
      console.warn("No user found!")

  @maybeUser : (f, defaultValue) ->
    currentUser = Parse.User.current()
    if currentUser
      f(currentUser)
    else
      defaultValue