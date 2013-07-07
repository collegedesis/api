App.OrganizationsShowController = Ember.ObjectController.extend
  needs: ['application']

  currentUser: (->
    @get('controllers.application.currentUser')
  ).property('controllers.application.currentUser')

  currentUserIsAdmin: (->
    @get('adminMemberships').mapProperty('user').contains(@get('currentUser'))
  ).property('adminMemberships.@each.user', 'currentUser')

  currentUserIsMember: (->
    @get('memberships').mapProperty('user').contains(@get('currentUser'))
  ).property('memberships.@each.user', 'currentUser')

  pendingAdminApplication: (->
    @get('pendingAdminApplications').mapProperty('user').contains(@get('currentUser'))
  ).property('pendingAdminApplications.@each.user', 'currentUser')

  currentUserStatus: (->
    if @get('currentUserIsAdmin')
      return "Administrator"
    else
      if @get('currentUserIsMember')
        return "Member"
      else
        return "Not a member"
  ).property('currentUserIsAdmin', 'currentUserIsMember')

  canApplyForAdmin: (->
    # is a member
    @get('currentUserIsMember') &&
    # is not an admin
    !@get('currentUserIsAdmin') &&
    # has not applied already
    !@get('pendingAdminApplication')
  ).property('currentUser', 'currentUserIsAdmin', 'pendingAdminApplication')

  applyAdmin: ->
    user = @get('currentUser')
    organization = @get('content')
    admin_type = App.MembershipType.find(2)
    App.MembershipApplication.createRecord
      user: user
      organization: organization
      membership_type: admin_type
      application_status_id: 1

    @get('store').commit()