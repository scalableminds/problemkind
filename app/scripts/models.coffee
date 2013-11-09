### define
app : app
./models/problem : Problem
###

Models =
  { 
    Problem
  }


app.addInitializer -> app.models = Models; return

Models