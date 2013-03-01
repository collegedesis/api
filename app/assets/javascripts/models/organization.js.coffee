CollegeDesis.Organization = DS.Model.extend
  memberships: DS.hasMany('CollegeDesis.Membership')
  name: DS.attr('string')
  university: DS.belongsTo('CollegeDesis.University')
  
  universityName: (-> @get("university.name")).property('university.name')
  
  displayName: (->
    @get("name") + " at " + @get('universityName')
  ).property('name', 'universityName')