CollegeDesis.LoginController = Ember.Controller.extend

  email: null
  password: null

  # state indicator
  loggingIn: false

  login: ->
    if @get("email")? && @get('password')?
      $.post("/sessions", email: @get('email'), password: @get('password'))
        .success (result) =>
          if result.error
            @set('loggingIn', false)
            alert result.error
          else
            # TODO we should remember the current route and load that again.
            window.location = "/"
        .fail (result) =>
          alert "Something bad happened. We're going to reload the page"
    else
      alert('enter an email and password, foo')