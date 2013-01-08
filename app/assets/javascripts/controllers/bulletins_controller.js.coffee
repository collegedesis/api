CollegeDesis.BulletinsController = Ember.ArrayController.extend

  hasBulletins: (->
    true if @get('content.lengt') > 0
  ).property('@')