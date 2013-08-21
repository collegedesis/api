App.LoginController = Ember.Controller.extend

  session: Ember.Object.create({email: null, password: null})

  # state indicator
  loggingIn: false

  submit: ->
    if @get("validEmail")? && @get('validPassword')?
      $.post("/sessions", email: @get('session.email'), password: @get('session.password'))
        .success (result) =>
          if result.error
            @set('loggingIn', false)
            alert result.error
          else
            # TODO we should remember the current route and load that again.
            window.location = "/directory"
        .fail (result) =>
          alert "Something bad happened. We're going to reload the page"
    else
      alert('enter an email and password, foo')

  errors: (->
    !(@get('validEmail') && @get('validPassword'))
  ).property('validEmail', 'validPassword')

  validEmail: (->
    if @get('session.email')?
      if @get('session.email').match(/^\S+@\S+$/) then true else false
    else
      false
  ).property('session.email')

  validPassword: (->
    @get('session.password')
  ).property('session.password')