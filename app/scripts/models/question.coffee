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

  

  setAnswer: (content) ->

  class @Collection extends Parse.Collection

    model : Question