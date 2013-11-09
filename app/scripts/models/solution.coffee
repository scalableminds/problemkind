### define
parse: Parse
###

class Solution extends Parse.Object

  className : "Solution"

  defaults : 
    content : ""
    isAccepted : false

  initialize : ->
    User.withUser( (user) =>
      @set("user", user)
      @save()
    )

  class @Collection extends Parse.Collection

    model: Solution