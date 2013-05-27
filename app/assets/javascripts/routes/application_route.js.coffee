App.ApplicationRoute = Ember.Route.extend
  setupController: (controller) ->
    if App.session.get("currentUserId")
      user = App.User.find(App.session.get('currentUserId'))
      controller.set('currentUser', user)
      controller.set('currentUserId', user.get('id'))

  events:
    goHome: -> @transitionTo('index')
    logout: ->
      id = App.session.get('currentUserId')
      $.ajax "/sessions/#{id}",
        type: 'DELETE'
        success: (result) =>
          window.location.reload()