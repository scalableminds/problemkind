### define
app : app
./views/problem_entry : ProblemEntry
./views/main_view : MainView
###

Views =
  { 
    ProblemEntry
    MainView
  }


app.addInitializer -> app.views = Views; return

Views