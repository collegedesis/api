App.OrganizationsController = Ember.ArrayController.extend

  publicOrgs: (->
    return @get('content').filterProperty('public', true) if @get('content')
  ).property('@each.public')