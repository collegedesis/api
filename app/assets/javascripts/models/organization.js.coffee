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

  twitterUrl: (->
    "http://twitter.com/" + @get('twitter')
  ).property('twitter')

  facebookUrl: (->
    "http://facebook.com/" + @get('facebook')
  ).property('facebook')

  youtubeUrl: (->
    "http://youtube.com/" + @get('youtube')
  ).property('youtube')

  websiteUrl: (->
    "http://" + @get('website[')
  ).property('website')