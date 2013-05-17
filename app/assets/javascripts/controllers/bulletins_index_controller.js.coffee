App.BulletinsIndexController = Ember.ArrayController.extend
  itemController: 'bulletin'
  needs: ['application']

  currentPage: 1
  numOfBulletins: 0

  hasBulletins: (-> true if @get('length') >= 1 ).property('@each')

  voteOnBulletin: (bulletin) ->
    if @get('controllers.application.currentUserId')
      vote = bulletin.get('votes').createRecord()
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

  transitionPage: (->
    @transitionToRoute('index')
  ).observes('page')

  firstPage: (->
    @get('currentPage') == 1
  ).property('currentPage')

  lastPage: (->
    if @get('numOfBulletins')
      true if @get('totalPages') == @get('currentPage')
  ).property('currentPage', 'totalPages')

  totalPages: (->
    (@get('numOfBulletins') / 10) if @get('numOfBulletins')
  ).property('numOfBulletins')

  nextPage: ->
    getPage = @get('currentPage') + 1
    @loadBulletins(getPage)

  previousPage: (controller) ->
    getPage = @get('currentPage') - 1
    @loadBulletins(getPage)

  loadBulletins: (page) ->
    page = page || 1
    xhr = @store.findQuery(App.Bulletin, {page: page})
    xhr.then (data) =>
      @set('content', data)
      @set('currentPage', page)

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