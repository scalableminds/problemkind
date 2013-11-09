### define
parse: Parse
./question: Question
###

class Answer extends Parse.Object

  className : "Answer"

  defaults : 
    content: "", 
    user : {}

  initialize : ->
    @questions = new (Question.Collection)()

  class @Collection extends Parse.Collection

    model: Answer