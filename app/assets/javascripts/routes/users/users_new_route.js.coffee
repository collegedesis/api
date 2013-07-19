App.UsersNewRoute = Ember.Route.extend
  model: -> App.User.createRecord()
  activate: (controller) -> $(document).attr('title', 'CollegeDesis - Signup')

  setupController: (controller, model) ->
    controller.set('content', model)
    email = controller.get('wipEmail')
    controller.set('content.email', email)

  redirect: ->
    App.session.set('messages', 'Already signed up!')
    user = @controllerFor('application').get('currentUser')
    @transitionTo('users.me') if user