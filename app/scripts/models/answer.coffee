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


  fetchAnswers : ->
    answers = _(@get("answers")).each( (answer, i) =>
      answer.fetch(
        success : =>
          @attributes["_answer#{i}"] = answer.get("answer")
          @trigger("change:_answer#{i}", answer.get("answer"))
      )
    )
    answers


  class @Collection extends Parse.Collection

    model: Answer