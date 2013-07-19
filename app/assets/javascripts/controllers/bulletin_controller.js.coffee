App.BulletinController = Ember.ObjectController.extend
  needs: ['application']

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
    # TODO this is funky because another user could have cast a vote from this IP
    # and this if someone else signed on they couldn't vote
    if App.session.get("votedBulletinIds")
      val = true if @get("controllers.application.votedBulletinIds").contains(parseInt(@get("id")))
    return val

  ).property('votes.@each.user.id', 'App.session.votedBulletinIds')