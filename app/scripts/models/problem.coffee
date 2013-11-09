### define
underscore : _
parse: Parse
./answer: Answer
./solution: Solution
./user: User
###

class Problem extends Parse.Object

  className : "Problem"

  defaults : 
    text : "Hallo Welt"
    answers: []
    thumbs : 0

  @create: ->
    User.withUser( (user) =>
      acl = new Parse.ACL(user)
      acl.setPublicReadAccess(true)
      p = new Problem(
        user: user
      )
      p.setACL(acl).save()
      p
    )


  @trending: (limit = 100) ->
    query = new Parse.Query(Problem)
    c = query.limit(limit).collection()
    c.fetch()
    c

  @keywordsIn: (str) ->
    str.replace(/[^A-Za-z\s]/g, "").split(" ")  

  @similar : (to, limit = 100) ->
    keywords = Problem.keywordsIn(to)
    query = new Parse.Query(Problem)
    answers = Parse.Query.or.apply(
      $, 
      keywords.map( (x) -> new Parse.Query(Answer).contains("content", x)))
    query.matchesQuery("answers", answers);
    c = query.limit(limit).collection()
    c.fetch()
    c

  firstAnswer : ->
    answers = @get("answers")
    if answers.length > 0
      a = answers[0]
      a.fetch(
        error: (answer, error) ->
          console.error("Couldn't fetch first answer: #{error}")
      )
      a


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

  addAnswer: (answer) ->
    @save()
    answer.set("answerTo", this)
    answer.save()
    @get("answers").push(answer)
    @save()

  addSolution : (content) ->
    User.withUser( (user) =>
      new Solution(
        content: content
        solutionTo: this
        user: user
      ).save()
    )

  thumbsUp : ->
    @set("thumbs", @get("thumbs") + 1)
    @save()
