CollegeDesis.NewUserController = Ember.ObjectController.extend

  createNewUser: ->
    if @get('password') == @get('password_confirmation')
      @store.commit()