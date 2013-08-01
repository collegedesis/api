App.Organization = DS.Model.extend
  memberships: DS.hasMany('App.Membership')
  name: DS.attr('string')
  display_name: DS.attr('string')
  location: DS.attr('string')
  slug: DS.attr('string')
  university_name: DS.attr('string')
  about: DS.attr('string')
  reputation: DS.attr('number')
  twitter: DS.attr('string')
  facebook: DS.attr('string')
  youtube: DS.attr('string')
  website: DS.attr('string')
  instagram: DS.attr('string')
  membership_applications: DS.hasMany('App.MembershipApplication')
  bulletins: DS.hasMany('App.Bulletin')

  adminMemberships: (->
    @get('memberships').filterProperty('membership_type.id', 2)
  ).property('memberships.@each.membership_type.id')

  nonAdminMemberships: (->
    @get('memberships').filterProperty('membership_type.id', 1)
  ).property('memberships.@each.membership_type.id')

  twitterUrl: (->
    "http://twitter.com/" + @get('twitter')
  ).property('twitter')

  facebookUrl: (->
    "http://facebook.com/" + @get('facebook')
  ).property('facebook')

  youtubeUrl: (->
    "http://youtube.com/" + @get('youtube')
  ).property('youtube')

  instagramUrl: (->
    "http://instagram.com/" + @get('instagram')
  ).property('instagram')

  websiteUrl: (->
    "http://" + @get('website')
  ).property('website')

  adminApplications: (->
    @get('membership_applications').filterProperty('membership_type.id', 2)
  ).property('membership_applications.@each.membership_type.id')

  pendingAdminApplications: (->
    @get('adminApplications').filterProperty('application_status_id', 1)
  ).property('adminApplications.@each.application_status_id')