App.BulletinsNewRoute = Ember.Route.extend
  redirect: (model) ->
    user = @controllerFor('application').get('currentUser')
    if user
     if !user.get('approved')
      App.session.set('messages', 'Add a Membership to post!')
      @transitionTo('users.show', user)
      model.deleteRecord() if model.get('isNew')
    else
      App.session.set('messages', 'You need to be logged in to post!')
      @transitionTo('login')
      model.deleteRecord() if model.get('isNew')

  model: -> App.Bulletin.createRecord({bulletin_type: 2})

  exit: -> @get('controller.content').deleteRecord() if @get('controller.content.isNew')