### define
parse: Parse
./question: Question
./user: User
###

class Answer extends Parse.Object

  className : "Answer"

  defaults : 
    question : ""
    answer: "" 
    answers: []

  @create : (attr = {}) ->
    User.withUser( (user) ->
      c = new Answer(_.extend(attr, { user }))
      c.save()
      c
    )


  addAnswer: (answer) ->
    answer.save()
    @get("answers").push(answer)
    @save()


  class @Collection extends Parse.Collection

    model: Answer