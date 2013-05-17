App.IndexRoute = Ember.Route.extend
  events:
    goToBulletin: (bulletin) ->
      @transitionTo('bulletins.show', bulletin)

    write: -> @transitionTo('bulletins.new')

  setupController: (controller) ->
    xhr = $.get '/info', (data) ->
      return data
    xhr.done (data) =>
      controller.set('numOfOrganizations', data.orgsCount)
      controller.set('numOfUniversities', data.universityCount)
      controller.set('numOfStates', data.stateCount)
      @controllerFor('bulletinsIndex').set('numOfBulletins', data.bulletinsCount)

    @controllerFor('bulletinsIndex').loadBulletins()

  activate: ->
    $(document).attr('title', 'CollegeDesis - News')