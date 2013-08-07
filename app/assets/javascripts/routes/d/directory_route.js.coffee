App.DirectoryRoute = Ember.Route.extend
  activate: -> $(document).attr('title', 'Directory - CollegeDesis')

  deactivate: ->
    controller = @controllerFor('map')
    controller.clearResults()

App.DIndexRoute = Ember.Route.extend
  redirect: -> @transitionTo('directory')