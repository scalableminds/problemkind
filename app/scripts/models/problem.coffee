### define
parse: Parse
###

class Problem extends Parse.Object

  constructor : -> 

  className : "Problem"

  defaults : 
    whys : [# { content: "", questions: []} #]
    user : {}

  addQuestion: ()
