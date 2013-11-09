### define
parse: Parse
./question: Question
./user: User
###

class Answer extends Parse.Object

  className : "Answer"

  defaults : 
    content: "" 
    questions: []

  @create : (content) ->
    User.withUser( (user) ->
      c = new Answer(
        user: user
        content: content
      )
      c.save()
      c
    )

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