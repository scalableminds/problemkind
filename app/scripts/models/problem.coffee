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
    thumbs : []
    numberOfThumbs: 0
    isCompleted: false

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
    c = query
      .equalTo("isCompleted", true)
      .descending("numberOfThumbs")
      .limit(limit)
      .collection()
    c.fetch()
    c

  @ownProblems: (limit = 100) ->
    User.maybeUser( (
      (user) ->
        query = new Parse.Query(Problem)
        c = query
          .equalTo("isCompleted", true)
          .equalTo("user", user)
          .descending("numberOfThumbs")
          .limit(limit)
          .collection()
        c.fetch()
        c
      ),  new (Problem.Collection))

  @keywordsIn: (str) ->
    str.replace(/[^A-Za-z\s]/g, "").split(" ")  

  @similar : (to, limit = 100) ->
    keywords = Problem.keywordsIn(to)
    query = new Parse.Query(Problem)
    answers = Parse.Query.or.apply(
      $, 
      keywords.map( (x) -> new Parse.Query(Answer).contains("content", x)))
    query.matchesQuery("answers", answers);
    c = query
      .limit(limit)
      .equalTo("isCompleted", true)
      .collection()
    c.fetch()
    c

  fetchAnswers : ->
    answers = _(@get("answers")).each( (answer, i) =>
      answer.fetch(
        success : =>
          @attributes["_answer#{i}"] = answer.get("content")
          @trigger("change:_answer#{i}", answer.get("content"))
      )
    )
    answers

  fetchAnswer : ->
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
    answer.set("answerTo", this)
    answer.save()
    @get("answers").push(answer)
    @save()

  complete: ->
    @set("isCompleted", true)
    @save()

  addSolution : (content) ->
    User.withUser( (user) =>
      new Solution(
        content: content
        solutionTo: this
        user: user
      ).save()
    )

  save : (args...) ->
    _(@attributes).forOwn( (value, key) =>
      delete @attributes[key] if key[0] == "_"
    )
    super(args...)

  canGiveThumbs : ->
    User.withUser( (user) => 
      not _(@get("thumbs")).find( (e) -> e.id == user.id)
    )

  thumbsUp : ->
    User.withUser( (user) => 
      if @canGiveThumbs()
        newThumbs = @get("thumbs").concat([ user ])
        @set("thumbs", newThumbs)
        @set("numberOfThumbs", newThumbs.length)
        @save()
    )

  thumbsDown : ->
    User.withUser( (user) => 
      newThumbs = _(@get("thumbs")).filter( (e) -> e.id != user.id).value() 
      @set("thumbs", newThumbs)
      @set("numberOfThumbs", newThumbs.length)
      @save()
    )

  class @Collection extends Backbone.Collection

    model : Problem
