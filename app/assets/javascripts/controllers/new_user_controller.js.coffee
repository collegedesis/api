App.NewUserController = Ember.ObjectController.extend
  needs: ['application']

  submit: ->
    @get('content').addObserver('id', this, '_userCreated')
    if !@get('errors')
      @store.commit()

  _userCreated: ->
    user = @get('content')
    user.removeObserver('id', this, '_userCreated')
    @_createSession(user)
    @transitionToRoute('index')

  organizations: (->
    if App.Organization.all().length > 1
      return App.Organization.all()
    else
      return App.Organization.find()
  ).property()

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
    !(@get("validName") && @get('validEmail') && @get('passwordMatch') && @get('validMembership'))
  ).property('validName', 'validEmail', 'passwordMatch', 'validMembership')

  # a valid name is anything that has is not null
  validName: (-> @get('full_name.length') ).property('full_name')

  # valid email has an @ preceded and succeeded by non-whitespace characters
  validEmail: (->
    if @get("email")?
      if @get('email').match(/^\S+@\S+$/) then true else false
  ).property('email')

  # passwords match if passwords match.
  # obvious statement is obvious.
  passwordMatch: (->
    @get('password') == @get("password_confirmation") && @get("password.length") >= 6
  ).property('password', 'password_confirmation')

  # valid membership is to an organization that has an email address.
  # also have to make sure an organization is selected.
  validMembership: (->
    org = @get('memberships.firstObject.organization')
    org? && org.get('has_email')
  ).property('memberships.firstObject.organization.has_email')