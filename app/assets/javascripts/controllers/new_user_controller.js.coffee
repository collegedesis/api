CollegeDesis.NewUserController = Ember.ObjectController.extend
  needs: ['application']

  createNewUser: ->
    @get('content').addObserver('id', this, '_userCreated')
    if @get('password') == @get('password_confirmation')
      @store.commit()

  _userCreated: ->
    user = @get('content')
    user.removeObserver('id', this, '_userCreated')
    @_createSession(user)
    @transitionToRoute('index')

  organizations: (->
    if CollegeDesis.Organization.all().length > 1
      return CollegeDesis.Organization.all()
    else
      return CollegeDesis.Organization.find()
  ).property()

  _createSession: (user) ->
    if !CollegeDesis.session
      CollegeDesis.session = Ember.Object.create
        currentUserId: user.id
        currentUser: user
      @set 'controllers.application.currentUserId', CollegeDesis.session.get('currentUserId')
      @set 'controllers.application.currentUser', CollegeDesis.session.get('currentUser')