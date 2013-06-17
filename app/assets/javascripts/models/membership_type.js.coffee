App.MembershipType = DS.Model.extend
  name: DS.attr('string')
  memberships: DS.hasMany('App.Membership')