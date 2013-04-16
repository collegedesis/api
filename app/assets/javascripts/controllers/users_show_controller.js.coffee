App.UsersShowController = Ember.ObjectController.extend
  needs: ['organizations']

  addMembership: -> @get('memberships').createRecord()

  organizations: (->
    @get('controllers.organizations.publicOrgs')
  ).property('controllers.organizations.publicOrgs')

  submit: -> @store.commit()

  dirtyRecords: (->
    @get('memberships').filterProperty('isNew', true).get('length') > 0
  ).property('memberships.@each.isNew')