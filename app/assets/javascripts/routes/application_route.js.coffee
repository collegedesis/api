App.ApplicationRoute = Ember.Route.extend
  setupController: (controller) ->
    if App.session.get("currentUserId")
      user = App.User.find(App.session.get('currentUserId'))
      controller.set('currentUser', user)
      controller.set('currentUserId', user.get('id'))

    $.get '/info', (data) =>
      controller.set('numOfOrganizations', data.orgsCount)
      controller.set('numOfUniversities', data.universityCount)
      controller.set('numOfStates', data.stateCount)
      @controllerFor('bulletinsIndex').set('numOfBulletins', data.bulletinsCount)

  events:
    goHome: -> @transitionTo('index')
    logout: ->
      id = App.session.get('currentUserId')
      $.ajax "/sessions/#{id}",
        type: 'DELETE'
        success: (result) =>
          window.location.reload()

  activate: ->
    @controllerFor('radio').initializeRadio()