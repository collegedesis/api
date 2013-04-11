App.Comment = DS.Model.extend
  body: DS.attr('string')
  bulletin: DS.belongsTo('App.Bulletin')
  author: DS.attr('string')