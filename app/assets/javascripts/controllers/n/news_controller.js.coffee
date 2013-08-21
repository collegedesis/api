App.BaseNewsController = Ember.ArrayController.extend
  needs: ['application', 'bulletinsIndex']
  currentUserBinding: Ember.Binding.oneWay('controllers.application.currentUser')

  numOfOrganizationsBinding: Ember.Binding.oneWay('controllers.application.numOfOrganizations')
  numOfUniversitiesBinding: Ember.Binding.oneWay('controllers.application.numOfUniversities')
  numOfStatesBinding: Ember.Binding.oneWay('controllers.application.numOfStates')

  incentives: [
    'events',
    'performances',
    'accomplishments'
  ]

  scrollToStories: ->
    pos = $('.bulletins-list .bulletin-wrapper:first').position().top
    $('body').animate({scrollTop: pos })

App.NIndexController = App.BaseNewsController.extend()
App.NewsController = App.BaseNewsController.extend()
App.NController = App.BaseNewsController.extend()