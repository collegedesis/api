App.User = DS.Model.extend
  full_name: DS.attr('string')
  email: DS.attr('string')
  password: DS.attr('string')
  password_confirmation: DS.attr('string')
  avatar_url: DS.attr('string')
  approved: DS.attr('boolean')

  memberships: DS.hasMany('App.Membership')
  membership_applications: DS.hasMany('App.MembershipApplication')
  bulletins: DS.hasMany('App.Bulletin')

  adminMemberships: (->
    t = App.MembershipType.find(2)
    @get('memberships').filterProperty('membership_type', t)
  ).property('memberships.@each.membership_type')

  adminOf: (orgId) ->
    @get('adminMemberships').mapProperty('organization.id').contains(orgId)

  memberOf: (orgId) ->
    @get('memberships').mapProperty('organization.id').contains(orgId)

  pendingMembershipApplications: (->
    @get('membership_applications').filterProperty('application_status_id', 1)
  ).property('membership_applications.@each.application_status_id')

  organizations: (->
    @get('memberships').mapProperty('organization')
  ).property('memberships.@each.organization')