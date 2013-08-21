App.DShowController = Ember.ObjectController.extend
  needs: ['application']

  noContactInfo: (->
    if !@get('website') && !@get('facebook') && !@get('instagram') && !@get('youtube') && !@get('twitter')
      true
    else
      false
  ).property('website', 'facebook', 'instagram', 'youtube', 'twitter')

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

  applyMembership: ->
    mem_type_id = 1 # regular member
    @createMembership(mem_type_id)

  applyAdmin: ->
    mem_type_id = 2 # admin member
    @createMembership(mem_type_id)

  createMembership: (mem_type_id) ->
    user = @get('currentUser')
    @transitionToRoute('login') if !user
    organization = @get('content')
    mem_type = App.MembershipType.find(mem_type_id)

    app = App.MembershipApplication.createRecord
      user: user
      organization: organization
      membership_type: mem_type
      application_status_id: 1

    app.addObserver('id', this, '_createdMembership')
    @get('store').commit()

  # TODO this should change when we upgrade ember-data
  # and start using a promise based commit
  _createdMembership: (app) ->
    app.get('organization').reload()
    app.get('user').reload()
    app.removeObserver('id', this, '_createdMembership')
