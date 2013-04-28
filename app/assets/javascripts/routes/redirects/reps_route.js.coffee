App.RepsRoute = Ember.Route.extend
  redirect: ->
    App.Organization.find(275).then (data) =>
      @transitionTo('organizations.show', data)