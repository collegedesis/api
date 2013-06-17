App.Membership = DS.Model.extend
  user: DS.belongsTo('App.User')
  organization: DS.belongsTo('App.Organization')
  approved: DS.attr('boolean')
  display_name: DS.attr('string')
  membership_type: DS.belongsTo('App.MembershipType')
  notApproved: (-> !@get('approved')).property('approved')

  loading: (->
    if @get('isLoaded') && @get('organization.isLoaded')
      return false
    else
      return true
  ).property('isLoaded', 'organization.isLoaded')