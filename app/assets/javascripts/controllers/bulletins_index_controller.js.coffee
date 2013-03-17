App.BulletinsIndexController = Ember.ArrayController.extend
  itemController: 'bulletin'

  hasBulletins: (->
    true if @get('length') > 0
  ).property('@each')

  voteOnBulletin: (bulletin) ->
    vote = bulletin.get('votes').createRecord()
    @store.commit()

App.BulletinController = Ember.ObjectController.extend

  hasBeenVotedOn: (->
    if App.session
      userId = App.session.get('currentUserId')
      if @get('votes').mapProperty('user.id').contains(userId.toString()) then true else false
    else
      false
  ).property('votes.@each.user.id')