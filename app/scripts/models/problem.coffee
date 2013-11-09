### define
parse: Parse
./answer: Answer
./solution: Solution
./user: User
###

class Problem extends Parse.Object

  className : "Problem"

  defaults : 
    answers: []
    thumbs : 0

  initialize : ->
    User.withUser( (user) =>
      @set("user", user)
      acl = new Parse.ACL(user)
      acl.setPublicReadAccess(true)
      @setACL(acl)
    )

  @trending: (limit = 100) ->
    query = new Parse.Query(Problem)
    c = query.collection()
    c.limit(100)
    c.fetch()
    c

  @similar : (to) ->
    query = new Parse.Query(Problem)
    answers = new Parse.Query(Answer)
    answers.equalTo("content", to)
    # query.matchesQuery("answers", answers);
    c = answers.collection()
    c

  firstAnswer : ->


  # withAnswers: (f) ->
  #   query = new Parse.Query(Answer)
  #   query.equalTo("answerTo", this);
  #   query.find(
  #     success: (answers) ->
  #       console.log("Successfully retrieved " + answers.length + " answers.")
  #       f(answers)

  #     error: (error) ->
  #       console.warn("Error: " + error.code + " " + error.message)
  #   )

  addQuestion : (answerIdx, content) ->
    # TODO: implement
    answers = @get("answers")
    if answerIdx < answers.length
      answers[answerIdx].fetch(
        success: (answer) ->
          answer.addQuestion(content)
        error: (answer, error) ->
          console.error("Couldn't fetch answers!")
      )

  addAnswer: (content) ->
    a = new Answer(
      content: content
      answerTo: this
    )
    a.save()
    @get("answers").push(a)
    @save()

  addSolution : (content) ->
    new Solution(
      content: content
      solutionTo: this
    ).save()

  thumbsUp : ->
    @set("thumbs", @get("thumbs") + 1)
    @save()
