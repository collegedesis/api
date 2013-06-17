App.OrganizationsShowController = Ember.ObjectController.extend
  needs: ['application']

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

  currentUserIsAdmin: (->
    orgId = @get('id')
    bool = @get('currentUser').memberOf(orgId)
    return bool
  ).property('currentUser.memberships.@each.membership_type', 'id')

  save: ->
    @get('store').commit()