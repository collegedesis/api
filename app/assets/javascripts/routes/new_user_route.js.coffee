App.UsersNewRoute = Ember.Route.extend
  model: -> App.User.createRecord()
  activate: -> $(document).attr('title', 'CollegeDesis - Signup')