App.ApplicationRoute = Ember.Route.extend
  setupController: (controller) ->
    if App.session.get("currentUserId")
      user = App.User.find(App.session.get('currentUserId'))
      controller.set('currentUser', user)
      controller.set('currentUserId', user.get('id'))

    $.get 'api/v1/info', (data) =>
      controller.set('numOfOrganizations', data.orgsCount)
      controller.set('numOfUniversities', data.universityCount)
      controller.set('numOfStates', data.stateCount)
      @controllerFor('bulletinsIndex').set('numOfBulletins', data.bulletinsCount)

  events:
    goHome: -> @transitionTo('index')
    goToHome: ->
      @get('controller').showNav()
      @transitionTo('index')
    goToN: ->
      @get('controller').showNav()
      @transitionTo('n.index')
    goToNews: ->
      @get('controller').showNav()
      @transitionTo('news')
    goToAbout: ->
      @get('controller').showNav()
      @transitionTo('about')
    goToDirectory: ->
      @get('controller').showNav()
      @transitionTo('directory')

    logout: ->
      id = App.session.get('currentUserId')
      $.ajax "/sessions/#{id}",
        type: 'DELETE'
        success: (result) =>
          window.location.reload()