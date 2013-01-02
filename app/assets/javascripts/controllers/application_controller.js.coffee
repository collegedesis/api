CollegeDesis.ApplicationController = Ember.Controller.extend()

  # currentRouteTitle: (->
  #   path = CollegeDesis.router.get('currentState.path').split('.')[1]
  #   switch path
  #     when "index" then "Home"
  #     else path.charAt(0).toUpperCase() + path.slice(1);
  # ).property('CollegeDesis.router.currentState.path')