App.NSubmitController = Ember.ObjectController.extend
  needs: ['application']

  currentUser: (->
    @get('controllers.application.currentUser')
  ).property('controllers.application.currentUser')


  # properties and actions for previewing bulletin
  showPreview: false
  preview: -> @set('showPreview', !@get('showPreview'))
  showingPreview: (-> @get("showPreview")).property('showPreview')

  ###
    Properties and functions needed to assign
    an author for a polymorphic relationship.
  ###
  possibleAuthors: (->
    arr = Em.A()
    currentUser = @get('currentUser')

    # TODO Sort this array instead of relying on the order objects are pushed in
    userObject = Ember.Object.create
      id: currentUser.get('id')
      name: currentUser.get('full_name')
      type: 'User'

    arr.pushObject(userObject)

    orgs = currentUser.get('organizations')

    orgs.forEach (item) ->
      if item
        orgObject = Ember.Object.create
          id: item.get('id')
          name: item.get('name')
          type: 'Organization'

        arr.pushObject(orgObject)

    return arr
  ).property('currentUser.organizations.@each.name')

  assignedAuthor: null # bound to selectBox in view

  _assignAuthor: ->
    author = @get('assignedAuthor')
    @set('content.author_id', author.get('id'))
    @set('content.author_type', author.get('type'))

  submit: ->
    @_assignAuthor()
    @get('content').addObserver('slug', this, '_createdBulletin')
    if !@get('errors')
      @get("store").commit()

  _createdBulletin: ->
    bulletin = @get('content')
    bulletin.removeObserver('slug', this, '_createdBulletin')
    @transitionToRoute("news.story", bulletin)

  errors: (->
    val = true
    if @get('bulletin_type') == 2
      if @get('title') && @get('url') && @get('validUrl') then val = false else val = true
    else if @get('bulletin_type') == 1
      if @get('title') && @get('body') then val = false else val = true
    return val
  ).property('title', 'url', 'body', 'validUrl')

  validUrl: (->
    @get('urlIncludesProtocol') && !@get('urlIsShortened')
  ).property('url')

  urlIsShortened: (->
    # TODO
    return false
  ).property('url')

  urlIncludesProtocol: (->
    @get('url').match(/^https?:\/\/.+\..+/) if @get('url')?
  ).property('url')

  toggleBulletinType: ->
    currentType = @get('bulletin_type')
    if currentType == 1 then newType = 2 else newType = 1
    @set('bulletin_type', newType)

  toggleTypePrompt: (->
    type = @get('bulletin_type')
    if type == 1
      "Post a link"
    else
      "Write a blog post"
  ).property('bulletin_type')