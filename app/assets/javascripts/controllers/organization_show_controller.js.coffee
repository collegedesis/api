App.OrganizationsShowController = Ember.ObjectController.extend
  needs: ['application']

  applied: false
  working: false

  registered: (->
    ids = @get('registeredUsers').mapProperty('id')
    currentUserId = @get('currentUser.id')
    if ids.contains currentUserId then true else false
  ).property('currentUser', 'registeredUsers.@each')

  currentUser: (->
    @get('controllers.application.currentUser')
  ).property('controllers.application.currentUser')

  registeredUsers: (->
    @get('memberships').mapProperty('user')
  ).property('memberships.@each.user')