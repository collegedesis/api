App.IndexController = Ember.Controller.extend
  needs: ['application', 'bulletinsIndex']
  currentUserBinding: Ember.Binding.oneWay('controllers.application.currentUser')

  numOfOrganizations: null