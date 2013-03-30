App.Organization = DS.Model.extend
  memberships: DS.hasMany('App.Membership')
  name: DS.attr('string')
  university: DS.belongsTo('App.University')
  has_email: DS.attr('boolean')
  public: DS.attr('boolean')

  universityName: (-> @get("university.name")).property('university.name')
  
  displayName: (->
    @get("name") + " at " + @get('universityName')
  ).property('name', 'universityName')