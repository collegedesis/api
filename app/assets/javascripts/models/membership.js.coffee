App.Membership = DS.Model.extend
  user: DS.belongsTo('App.User')
  organization: DS.belongsTo('App.Organization')
  approved: DS.attr('boolean')
  display_name: DS.attr('string')

  notApproved: (-> !@get('approved')).property('approved')