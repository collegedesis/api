CollegeDesis.ApplicationController = Ember.Controller.extend
  # We'll set this property when someone signs in or signs up successfully
  currentUser: null

  # returns bool if the current controller exists.
  isSignedIn: (-> @get("currentUser") != null ).property('currentUser')