App.User = DS.Model.extend
  full_name: DS.attr('string')
  email: DS.attr('string')
  password: DS.attr('string')
  password_confirmation: DS.attr('string')

  memberships: DS.hasMany('App.Membership')