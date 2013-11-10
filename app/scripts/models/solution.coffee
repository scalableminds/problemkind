### define
parse: Parse
###

class Solution extends Parse.Object

  className : "Solution"

  defaults : 
    content : ""
    isAccepted : false

  class @Collection extends Parse.Collection

    model: Solution