CollegeDesis.NewUserController = Ember.ObjectController.extend
  needs: ['application']

  createNewUser: ->
    @get('content').addObserver('id', this, '_userCreated')
    if @get('password') == @get('password_confirmation')
      @store.commit()

  _userCreated: ->
    user = @get('content')
    user.removeObserver('id', this, '_userCreated')
    @set("controllers.application.currentUser", user)
    @transitionToRoute('index')