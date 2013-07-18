App.AboutIndexRoute = Ember.Route.extend
  redirect: -> @transitionTo('about.quick-start')