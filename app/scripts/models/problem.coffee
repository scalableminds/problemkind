### define
parse: Parse
./answer: Answer
###

class Problem extends Parse.Object

  className : "Problem"

  defaults : 
    user : {}
    thumbs : 0

  initialize : ->
    @answers = new (Answer.Collection)()

  addQuestion : (whyIdx, content) ->
    if whyIdx < whys.length
      whys[whyIdx].push() 

  thumbsUp : ->
    @set("thumbs", @thumbs + 1)
    @save()
