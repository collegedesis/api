App.NewUserController = Ember.ObjectController.extend
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