App.NSubmitRoute = Ember.Route.extend
  redirect: (model) ->
    user = @controllerFor('application').get('currentUser')
    if user
     if !user.get('approved')
      App.session.set('messages', 'Add a Membership to post!')
      @transitionTo('users.me')
    else
      App.session.set('messages', 'You need to be logged in to post!')
      @transitionTo('login')

  setupController: (controller) ->
    bulletin = App.Bulletin.createRecord({bulletin_type: 2})
    controller.set('content', bulletin)

  exit: -> @get('controller.content').deleteRecord() if @get('controller.content.isNew')