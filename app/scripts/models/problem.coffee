### define
underscore : _
parse: Parse
backbone: Backbone
./answer: Answer
./solution: Solution
./user: User
###

class Problem extends Parse.Object

  className : "Problem"

  defaults : 
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
      keywords.map( (x) -> new Parse.Query(Answer).contains("answer", x)))
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
          @attributes["_answer#{i}"] = answer.get("answer")
          @trigger("change:_answer#{i}", answer.get("answer"))
      )
    )
    answers


  addAnswer: (answer) ->
    answer.save()
    newAnswers = @get("answers").concat([answer])
    @set("answers", newAnswers)
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

