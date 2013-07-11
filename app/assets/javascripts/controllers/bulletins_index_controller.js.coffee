App.BulletinsIndexController = Ember.ArrayController.extend
  itemController: 'bulletin'
  needs: ['application']

  currentPage: 1
  numOfBulletins: 0
  loading: false

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
      @get('totalPages') == @get('currentPage')
  ).property('currentPage', 'totalPages')

  totalPages: (->
    if @get('numOfBulletins')
      pages = @get('numOfBulletins') / 10
      return Math.ceil(pages)
  ).property('numOfBulletins')

  nextPage: ->
    currentPage = parseInt(@get('currentPage'))
    getPage = currentPage + 1
    @transitionToRoute('news.page', {page: getPage })

  previousPage: (controller) ->
    currentPage = parseInt(@get('currentPage'))
    getPage = currentPage - 1
    @transitionToRoute('news.page', {page: getPage })