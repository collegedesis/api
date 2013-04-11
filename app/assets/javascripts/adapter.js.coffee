App.Serializer = DS.RESTSerializer.extend
  addAttributes: (data, record) ->
    # TODO: _addAttribute is private, should resort to using public apis
    # Add attribute to serialized object if it's not supposed to be excluded
    switch record.constructor
      when App.Bulletin
        record.eachAttribute (name, attribute) =>
          @_addAttribute(data, record, name, attribute.type) if name != "author"
      when App.User
        record.eachAttribute (name, attribute) =>
          @_addAttribute(data, record, name, attribute.type) if name != "avatar_url"
      when App.Membership
        record.eachAttribute (name, attribute) =>
          @_addAttribute(data, record, name, attribute.type) if name != "display_name"
      else
        @_super(data,record)

App.Adapter = DS.RESTAdapter.extend
  serializer: App.Serializer
  didError: (store, type, record, xhr) ->
    if type == App.User
      switch xhr.status
        when 422 # validation error
          if confirm("Looks like you either found a bug or tried to submit a form that fails validations. Let's reload the window and try again?")
            window.location.reload()
          else
            alert("So you're not going to play nice eh? Sorry, we have to reload anyway.")
            window.location.reload()
        when 401
          ###
            If we hit this code it means that someone tried
            to create a user with an email address that already
            exists but they entered the wrong password.
            It's a funky state, and we should be handling it better.
          ###
          if record.constructor == App.User
            console.log 'Something bad happened'
            # window.location.reload()
        else
          @_super.apply(this, arguments)
    else
      @_super.apply(this, arguments)

App.Adapter.configure "plurals",
  university: "universities"