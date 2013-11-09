### define
parse: Parse
###

class Question extends Parse.Object

  className : "Question"

  defaults : 
    answer : {}
    user : {}

  initialize : ->

  class @Collection extends Parse.Collection

    model : Question