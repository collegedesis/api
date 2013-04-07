App.OrganizationsController = Ember.ArrayController.extend

  publicOrgs: (->
    return @get('content').filterProperty('exposed', true) if @get('content')
  ).property('@each.exposed')