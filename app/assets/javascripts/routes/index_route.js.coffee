App.IndexRoute = Ember.Route.extend
  deactivate: ->
    mapController = @controllerFor('map')
    mapController.setProperties
      selectedStates: Em.A()
      queries: 0