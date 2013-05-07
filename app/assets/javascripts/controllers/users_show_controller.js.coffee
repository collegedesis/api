App.UsersShowController = Ember.ObjectController.extend
  needs: ['organizationsIndex']

  addMembership: -> @get('memberships').createRecord()

  submit: ->
    @get('memberships').forEach (item) ->
      item.one "didCreate", this, ->
        item.get('user').reload()
    @store.commit()

  cancel: ->
    @get('memberships').forEach (item) ->
      item.deleteRecord() if item.get('isNew')

  deleteMembership: (mem) ->
    org = mem.get('organization.name')
    if confirm("Are you sure you want to remove your membership from #{org}?")
      mem.deleteRecord()
      @store.commit()

  dirtyRecords: (->
    @get('memberships').filterProperty('isNew', true).get('length') > 0
  ).property('memberships.@each.isNew')