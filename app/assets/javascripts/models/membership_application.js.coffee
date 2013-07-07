App.MembershipApplication = DS.Model.extend
  user: DS.belongsTo('App.User')
  membership_type: DS.belongsTo('App.MembershipType')
  organization: DS.belongsTo('App.Organization')
  application_status_id: DS.attr('number')

  membership_type_name: (->
    if @get("membership_type.id") == 1
      "a Member"
    else
      "an Administrator"
  ).property('membership_type.id')

  status: (->
    switch @get('application_status_id')
      when 1
        "pending"
      when 2
        "approved"
      when 3
        "rejected"
      else
        "Not sure"
  ).property('application_status_id')