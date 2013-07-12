App.NewsIndexController = Ember.ArrayController.extend
  needs: ['application']
  currentUserBinding: Ember.Binding.oneWay('controllers.application.currentUser')

  numOfOrganizationsBinding: Ember.Binding.oneWay('controllers.application.numOfOrganizations')
  numOfUniversitiesBinding: Ember.Binding.oneWay('controllers.application.numOfUniversities')
  numOfStatesBinding: Ember.Binding.oneWay('controllers.application.numOfStates')

  incentives: [
    'events',
    'performances',
    'accomplishments'
  ]