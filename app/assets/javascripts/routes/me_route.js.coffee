App.MeRoute = Ember.Route.extend
  redirect: ->
    user = @controllerFor('application').get('currentUser')
    if !user
      App.session.set('messages', "You aren't logged in!")
      @transitionTo('login')

  model: ->
    id = App.session.get('currentUserId')
    App.User.find(id)

  setupController: (controller, model) ->
    controller.set('content', model)
    orgsController = @controllerFor('dIndex')
    orgsController.set('content', App.Organization.find())

  deactivate: ->
    App.session.set('messages', null)
    @get('controller.content.membership_applications').forEach (item) ->
      item.deleteRecord() if item.get('isNew')