### define
app : app
./models/problem : Problem
./models/question : Question
./models/solution : Solution
###

Models =
  { 
    Problem
    Question
    Solution
  }


app.addInitializer -> app.models = Models; return

Models