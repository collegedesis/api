App.Organization = DS.Model.extend
  memberships: DS.hasMany('App.Membership')
  name: DS.attr('string')
  display_name: DS.attr('string')
  location: DS.attr('string')
  slug: DS.attr('string')
  university_name: DS.attr('string')
  about: DS.attr('string')
  bulletins: DS.hasMany('App.Bulletin')
  reputation: DS.attr('number')
  twitter: DS.attr('string')
  facebook: DS.attr('string')
  youtube: DS.attr('string')
  website: DS.attr('string')