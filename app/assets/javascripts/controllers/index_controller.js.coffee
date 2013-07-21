App.IndexController = Ember.Controller.extend
  needs: ['application', 'usersNew']

  numOfOrganizationsBinding: Ember.Binding.oneWay('controllers.application.numOfOrganizations')
  numOfUniversitiesBinding: Ember.Binding.oneWay('controllers.application.numOfUniversities')
  numOfStatesBinding: Ember.Binding.oneWay('controllers.application.numOfStates')

  email: null

  proceedSignUp: ->
    @set('controllers.usersNew.wipEmail', @get('email'))
    @transitionToRoute('users.new')

  organizations: null