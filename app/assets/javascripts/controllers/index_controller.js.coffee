App.IndexController = Ember.Controller.extend
  needs: ['usersNew', 'map']

  numOfOrganizationsBinding: Ember.Binding.oneWay('controllers.map.numOfOrganizations')
  numOfUniversitiesBinding: Ember.Binding.oneWay('controllers.map.numOfUniversities')
  numOfStatesBinding: Ember.Binding.oneWay('controllers.map.numOfStates')

  organizations: null