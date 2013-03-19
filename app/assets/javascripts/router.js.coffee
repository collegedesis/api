App.Router.map ->
  @route("store")
  @route("calendar")
  @resource "bulletins", ->
    @route "new"
    @route "show", {path: ':slug'}
  @route "newUser", {path: 'signup'}
  @route 'login', {path: 'login'}

App.ApplicationRoute = Ember.Route.extend
  setupController: (controller) ->
    if App.session.get("currentUserId")
      user = App.User.find(App.session.get('currentUserId'))
      controller.set('currentUser', user)

  events:
    logout: ->
      id = App.session.get('currentUserId')
      $.ajax "/sessions/#{id}",
        type: 'DELETE'
        success: (result) =>
          window.location.reload()
    
App.BulletinsIndexRoute = Ember.Route.extend
  events: 
    goToBulletin: (bulletin) ->
      @transitionTo('bulletins.show', bulletin)
  model: ->
    return App.Bulletin.find()

App.BulletinsShowRoute = Ember.Route.extend
  serialize: (model, params) ->
    object = {}
    name = params[0]
    object[name] = Em.String.dasherize model.get('title')
    return object

  deserialize: (params) ->
    slug = params.slug
    title = slug.split('-').join(' ') if slug
    bulletins = App.Bulletin.find({title: title})

    bulletins.one "didLoad", ->
      bulletins.resolve(bulletins.get("firstObject"))

    @currentModel = bulletins

App.BulletinsNewRoute = Ember.Route.extend
  redirect: ->
    if !App.session
      @transitionTo('login')
  model: -> App.Bulletin.createRecord()

  exit: ->
    if @get('controller.content.isNew')
      @get('controller.content').deleteRecord()

App.NewUserRoute = Ember.Route.extend
  model: -> App.User.createRecord()

  setupController: (controller) ->
    user = controller.get('content')
    user.get('memberships').createRecord()