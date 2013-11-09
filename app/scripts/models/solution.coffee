### define
parse: Parse
###

class Solution extends Parse.Object

  constructor : -> 

  className : "Solution"

  defaults : 
    content : ""
    isAccepted : false
    user : {}