# CollegeDesis.User = DS.Model.extend
#   first_name: DS.attr('string')
#   last_name: DS.attr('string')
#   email: DS.attr('string')
#   memberships: DS.hasMany('CollegeDesis.Membership')

#   name: (-> "#{@get('first_name')} #{@get('last_name')}" ).property('first_name', 'last_name')