App.BulletinsIndexController = Ember.ArrayController.extend

  hasBulletins: (->
    true if @get('length') > 0
  ).property('@each')
