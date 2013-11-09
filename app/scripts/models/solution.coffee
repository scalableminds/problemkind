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
    )

  class @Collection extends Parse.Collection

    model: Solution