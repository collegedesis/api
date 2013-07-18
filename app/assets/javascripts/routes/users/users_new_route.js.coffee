App.UsersNewRoute = Ember.Route.extend
  model: -> App.User.createRecord()
  activate: -> $(document).attr('title', 'CollegeDesis - Signup')
  redirect: ->
    App.session.set('messages', 'Already signed up!')
    user = @controllerFor('application').get('currentUser')
    @transitionTo('users.me') if user