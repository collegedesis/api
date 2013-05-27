App.NewsController = Ember.Controller.extend
  needs: ['application', 'bulletinsIndex']
  currentUserBinding: Ember.Binding.oneWay('controllers.application.currentUser')

  numOfOrganizationsBinding: Ember.Binding.oneWay('controllers.application.numOfOrganizations')
  numOfUniversitiesBinding: Ember.Binding.oneWay('controllers.application.numOfUniversities')
  numOfStatesBinding: Ember.Binding.oneWay('controllers.application.numOfStates')