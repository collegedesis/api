App.UsersShowController = Ember.ObjectController.extend
  needs: ['organizationsIndex']

  loading: false

  newMembershipApplication: ->
    member_type = App.MembershipType.find(1) # Member (see constants.rb)
    @get('membership_applications').createRecord
      membership_type: member_type
      application_status_id: 1

  submit: ->
    @get('membership_applications').forEach (item) ->
      item.one "didCreate", this, ->
        item.get('user').reload()
    @store.commit()

  cancel: ->
    @get('membership_applications').forEach (item) ->
      item.deleteRecord() if item.get('isNew')

  deleteMembership: (mem) ->
    org = mem.get('organization.name')
    if confirm("Are you sure you want to remove your membership from #{org}?")
      mem.deleteRecord()
      @store.commit()

  newApplications: (->
    @get('membership_applications').filterProperty('isNew', true).get('length')
  ).property('membership_applications.@each.isNew')