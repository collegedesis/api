App.Organization = DS.Model.extend
  memberships: DS.hasMany('App.Membership')
  name: DS.attr('string')
  has_email: DS.attr('boolean')
  exposed: DS.attr('boolean')
  display_name: DS.attr('string')