### define
parse: Parse
###

class Question extends Parse.Object

  constructor : -> 

  className : "Question"

  defaults : 
    content : ""
    answer : ""
    user : {}