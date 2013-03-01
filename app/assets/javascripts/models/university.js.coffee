CollegeDesis.University = DS.Model.extend
  name: DS.attr('string')
  organizations: DS.hasMany('CollegeDesis.Organization')