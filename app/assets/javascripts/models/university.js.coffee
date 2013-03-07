App.University = DS.Model.extend
  name: DS.attr('string')
  organizations: DS.hasMany('App.Organization')