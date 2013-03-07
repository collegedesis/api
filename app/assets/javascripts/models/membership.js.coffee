App.Membership = DS.Model.extend
  user: DS.belongsTo('App.User')
  organization: DS.belongsTo('App.Organization')