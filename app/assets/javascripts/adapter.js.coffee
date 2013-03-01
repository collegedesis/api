CollegeDesis.Adapter = DS.RESTAdapter.extend
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
        if record.constructor == CollegeDesis.User
          window.location.reload()
      else
        @_super.apply(this, arguments)

CollegeDesis.Adapter.configure "plurals",
  university: "universities"