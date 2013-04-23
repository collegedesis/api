App.LoginRoute = Ember.Route.extend
  deactivate: -> App.session.set("messages", null)