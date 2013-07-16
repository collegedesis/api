App.UsersMeRoute = Ember.Route.extend
  redirect: ->
    user = @controllerFor('application').get('currentUser')
    if !user
      App.session.set('messages', "You aren't logged in!")
      @transitionTo('login')

  model: ->
    id = App.session.get('currentUserId')
    App.User.find(id)