CollegeDesis.IndexController = Ember.Controller.extend
  needs: ['application']
  currentUserBinding: Ember.Binding.oneWay('controllers.application.currentUser')