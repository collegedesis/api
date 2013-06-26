App.OrganizationsSettingsController = Ember.ObjectController.extend

  needs: ['application']

  currentUser: (->
    @get('controllers.application.currentUser')
  ).property('controllers.application.currentUser')

  currentUserIsAdmin: (->
    if this.get('currentUser')
      @get('currentUser').adminOf @get('id')
  ).property('currentUser.memberships.@each.membership_type', 'id')

  currentUserIsMember: (->
    if @get('currentUser')
      @get('currentUser').memberOf @get('id')
  ).property('currentUser.memberships.@each.membership_type', 'id')
