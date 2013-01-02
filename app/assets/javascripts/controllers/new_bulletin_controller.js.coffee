CollegeDesis.NewBulletinController = Ember.ObjectController.extend

  submit: ->
    @get('store').commit()
    CollegeDesis.router.send('goToBulletins')