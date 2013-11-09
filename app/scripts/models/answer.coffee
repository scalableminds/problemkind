### define
parse: Parse
./question: Question
###

class Answer extends Parse.Object

  className : "Answer"

  defaults : 
    content: "" 
    questions: []
    answerTo: {}
    user : {}

  initialize : ->
    # @set("questions", new (Question.Collection)())

  addQuestion: (content) ->
    q = new Question(
      content: content
      questionTo: this
    )
    q.save()
    @get("questions").push(q)
    @save()

  class @Collection extends Parse.Collection

    model: Answer