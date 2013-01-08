CollegeDesis.BulletinsController = Ember.ArrayController.extend

  hasBulletins: (->
    true if @get('length') > 0
  ).property('@each')