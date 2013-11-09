### define
parse: Parse
###

class Question extends Parse.Object

  className : "Question"

  defaults : 
    content: ""
    questionTo: {}
    answer : {}
    user : {}

  setAnswer: (user, content) ->

  class @Collection extends Parse.Collection

    model : Question