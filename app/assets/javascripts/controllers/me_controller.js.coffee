App.MeController = Ember.ObjectController.extend
  needs: ['dIndex', 'application']

  loading: false

  deleteMembership: (mem) ->
    org = mem.get('organization.name')
    if confirm("Are you sure you want to remove your membership from #{org}?")
      mem.deleteRecord()
      @store.commit()

  numOfOrganizations: (->
    @get('controllers.application.numOfOrganizations')
  ).property('controllers.application.numOfOrganizations')