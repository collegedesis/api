App.BulletinsShowController = Ember.ObjectController.extend
  needs: ['application']
  comment: null

  submitComment: ->
    user = @get('controllers.application.currentUser')
    if user
      if !user.get('approved')
        App.session.set('messages', 'Add a Membership to comment!')
        @transitionToRoute('users.show', user)
        @set('comment', null)
      else
        @get('comments').createRecord({body: @get('comment')})
        @store.commit()
        @set('comment', null)
    else
      App.session.set('messages', 'You need to be logged in to comment!')
      @transitionToRoute('login')
      @set('comment', null)

  voteOnBulletin: ->
    if @get('controllers.application.currentUserId')
      vote = @get('votes').createRecord()
      vote.addObserver('id', this, '_voted')
      @store.commit()
    else
      App.session.set('messages', 'You need to be logged in to vote!')
      @transitionToRoute('login')

  _voted: (vote) ->
    App.session.set('votedBulletinIds', []) if !App.session.get('votedBulletinIds')
    votedBulletinId = vote.get('bulletin.id')
    App.session.get('votedBulletinIds').pushObject parseInt(votedBulletinId)
    vote.removeObserver('id', this, '_voted')

  hasBeenVotedOn: (->
    # by default bulletin hasn't been voted on
    val = false

    # if there's a current user, we'll check all the votes of this bulletin
    # and see if the user matches the one logged in
    if App.session.get('currentUserId')
      userId = App.session.get('currentUserId')
      val = true if @get('votes').mapProperty('user.id').contains(userId.toString())

    # we'll check the session to see if a vote was cast from this IP.
    # the session is set by the server
    if App.session.get("votedBulletinIds")
      val = true if @get("controllers.application.votedBulletinIds").contains(parseInt(@get("id")))
    return val

  ).property('votes.@each.user.id', 'App.session.votedBulletinIds')