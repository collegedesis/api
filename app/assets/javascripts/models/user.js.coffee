App.User = DS.Model.extend
  full_name: DS.attr('string')
  email: DS.attr('string')
  password: DS.attr('string')
  password_confirmation: DS.attr('string')
  avatar_url: DS.attr('string')

  memberships: DS.hasMany('App.Membership')
  bulletins: DS.hasMany('App.Bulletin')
  errors: []