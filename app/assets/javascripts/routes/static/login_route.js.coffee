App.LoginRoute = Ember.Route.extend
  deactivate: -> App.session.set("messages", null)
  activate: -> $(document).attr('title', 'CollegeDesis - Login')