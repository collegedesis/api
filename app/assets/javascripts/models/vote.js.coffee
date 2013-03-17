App.Vote = DS.Model.extend
  user: DS.belongsTo('App.User')
  bulletin: DS.belongsTo('App.Bulletin')