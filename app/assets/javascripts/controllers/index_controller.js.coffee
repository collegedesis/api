App.IndexController = Ember.Controller.extend
  needs: ['usersNew', 'map']

  numOfOrganizationsBinding: Ember.Binding.oneWay('controllers.map.numOfOrganizations')
  numOfUniversitiesBinding: Ember.Binding.oneWay('controllers.map.numOfUniversities')
  numOfStatesBinding: Ember.Binding.oneWay('controllers.map.numOfStates')

  # This `email` property is a floating property
  # we send to the users.new controller
  # when `proceedSignUp` is called,
  email: null
  proceedSignUp: ->
    @set('controllers.usersNew.wipEmail', @get('email'))
    @transitionToRoute('users.new')

  organizations: null