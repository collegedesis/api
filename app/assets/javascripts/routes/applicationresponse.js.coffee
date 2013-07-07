App.ApplicationresponseRoute = Ember.Route.extend
  model: (params) ->
    App.MembershipApplication.find(params.id)
