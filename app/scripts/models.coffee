### define
app : app
./models/problem : Problem
./models/question : Question
./models/solution : Solution
./models/answer : Answer
###

Models =
  { 
    Problem
    Question
    Solution
    Answer
  }


app.addInitializer -> app.models = Models; return

Models