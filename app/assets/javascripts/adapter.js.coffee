App.Serializer = DS.RESTSerializer.extend

  # when creating a new User, we'll embed the memberships array
  addHasMany: (data, record, attribute, relationshipDesc) ->
    switch record.constructor
      when App.User
        if attribute == "memberships" and record.get('isNew')
          data[attribute+"_attributes"] = Em.A([])
          record.get(attribute).forEach (item) ->
            data[attribute+"_attributes"].pushObject item.serialize({includeId: true})
      else
        @_super(data, record, attribute, relationshipDesc)


App.Adapter = DS.RESTAdapter.extend
  serializer: App.Serializer

  didError: (store, type, record, xhr) ->
    switch xhr.status
      # This was already part of ember-data so we'll use it
      when 422
        data = JSON.parse(xhr.responseText)
        store.recordWasError(record, data['errors'])
      when 401
        ###
        If we hit this code it means that someone tried 
        to create a user with an email address that already 
        exists but they entered the wrong password. 
        It's a funky state, but we should be handling it better
        than we are now.
        ###
        if record.constructor == App.User
          window.location.reload()
      else
        @_super.apply(this, arguments)

  # We won't save membership records when they're created.
  # We'll embed them into the User record when it's created.
  # TODO we should use `embedded` api but might need an
  # ember-data update on that.
  shouldSave: (record) ->
    switch record.constructor
      when App.Membership
        if record.get('isNew') then return false
    return true

App.Adapter.configure "plurals",
  university: "universities"