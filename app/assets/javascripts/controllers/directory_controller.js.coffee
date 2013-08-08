App.DirectoryController = Ember.Controller.extend
  needs: ['map']

  numOfOrganizationsBinding: Ember.Binding.oneWay('controllers.map.numOfOrganizations')
  numOfUniversitiesBinding: Ember.Binding.oneWay('controllers.map.numOfUniversities')
  numOfStatesBinding: Ember.Binding.oneWay('controllers.map.numOfStates')