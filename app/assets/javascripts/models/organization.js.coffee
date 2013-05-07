App.Organization = DS.Model.extend
  memberships: DS.hasMany('App.Membership')
  name: DS.attr('string')
  display_name: DS.attr('string')
  location: DS.attr('string')
  slug: DS.attr('string')
  university_name: DS.attr('string')

  bulletins: DS.hasMany('App.Bulletin')