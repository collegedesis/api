CollegeDesis.SessionController = Ember.ObjectController.extend
  
  currentUser: null

  isLoggedIn: (->
    return true if @get('currentUser.constructor') == CollegeDesis.User
  ).property('currentUser')