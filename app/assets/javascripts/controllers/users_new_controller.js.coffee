App.UsersNewController = Ember.ObjectController.extend

  working: false

  submit: ->
    @get('content').addObserver('id', this, '_userCreated')
    if !@get('errors')
      @set('working', true)
      @store.commit()

  _userCreated: ->
    user = @get('content')
    user.removeObserver('id', this, '_userCreated')
    @set('working', false)
    @transitionToRoute('login')

  _createSession: (user) ->
    if !App.session
      App.session = Ember.Object.create
        currentUserId: user.id
        currentUser: user
      @set 'controllers.application.currentUserId', App.session.get('currentUserId')
      @set 'controllers.application.currentUser', App.session.get('currentUser')


  # errors check for valid name and email, matching passwords,
  # and that an org with an email address is selected
  errors: (->
    !(@get("validName") && @get('validEmail') && @get('validPassword') && @get('passwordMatch'))
  ).property('validName', 'validEmail', 'passwordMatch')

  # a valid name is anything that has is not null
  validName: (-> @get('full_name.length') ).property('full_name')

  # valid email has an @ preceded and succeeded by non-whitespace characters
  validEmail: (->
    if @get("email")?
      if @get('email').match(/^\S+@\S+$/) then true else false
  ).property('email')

  # password is at least six characters
  validPassword: (-> @get('password.length') >= 6 ).property('password')

  passwordMatch: (->
    @get('password') == @get("password_confirmation")
  ).property('password', 'password_confirmation')