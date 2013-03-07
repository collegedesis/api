CollegeDesis.BulletinsNewController = Ember.ObjectController.extend

  submit: ->
    @get("store").commit()
    @transitionToRoute("bulletins.index")