App.IndexRoute = Ember.Route.extend

  setupController: (controller) ->
    memberships = App.Membership.find()
    memberships.then (data) =>
      controller.set('memberships', memberships)

  deactivate: ->
    mapController = @controllerFor('map')
    mapController.setProperties
      selectedStates: Em.A()
      queries: 0