CollegeDesis.NewBulletinController = Ember.ObjectController.extend
  submit: ->
    @get('store').commit()
    @get("target").transitionTo('bulletins')