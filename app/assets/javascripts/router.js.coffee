App.Router.map ->
  @route("store")
  @route("calendar")
  @route("about")
  @resource "bulletins", ->
    @route "new"
    @route "show", {path: ':slug'}
  @route "newUser", {path: 'signup'}
  @route 'login', {path: 'login'}
  @resource "organizations", ->
    @route "show", {path: ':organization_id'}
  @resource "users", ->
    @route "show", {path: ':user_id'}

App.LoginRoute = Ember.Route.extend
  deactivate: ->
    App.session.set("messages", null)

App.IndexRoute = Ember.Route.extend
  events:
    goToBulletin: (bulletin) ->
      if bulletin.get('isPost')
        @transitionTo('bulletins.show', bulletin)
      else
        window.open(bulletin.get('url'))
    write: -> @transitionTo('bulletins.new')

  setupController: (controller) ->
    @controllerFor('bulletinsIndex').set('content', App.Bulletin.find())

App.UsersShowRoute = Ember.Route.extend
  redirect: (params) ->
    if App.session.get("currentUserId")
      if App.session.get('currentUserId') != parseInt(params.id)
        id = App.session.get('currentUserId')
        user = App.User.find(id)
        @transitionTo('index')
    else
      @transitionTo('index')

  model: (params) -> App.User.find(params.user_id)

  setupController: (controller) ->
    user = controller.get('content')
    @controllerFor('organizations').set('content', App.Organization.find())

App.OrganizationsShowRoute = Ember.Route.extend
  model: (params) -> return App.Organization.find(params.organization_id)

App.ApplicationRoute = Ember.Route.extend
  setupController: (controller) ->
    if App.session.get("currentUserId")
      user = App.User.find(App.session.get('currentUserId'))
      controller.set('currentUser', user)
      controller.set('currentUserId', user.get('id'))

  events:
    logout: ->
      id = App.session.get('currentUserId')
      $.ajax "/sessions/#{id}",
        type: 'DELETE'
        success: (result) =>
          window.location.reload()

App.BulletinsIndexRoute = Ember.Route.extend
  redirect: -> @transitionTo('index')

App.BulletinsShowRoute = Ember.Route.extend
  serialize: (model, params) ->
    object = {}
    name = params[0]
    object[name] = model.get('slug')
    return object

  model: (params) -> App.Bulletin.find(params.slug)

App.BulletinsNewRoute = Ember.Route.extend
  redirect: -> @transitionTo('login') if !App.session.get('currentUserId')
  model: -> App.Bulletin.createRecord({bulletin_type: 1})
  exit: -> @get('controller.content').deleteRecord() if @get('controller.content.isNew')

App.NewUserRoute = Ember.Route.extend
  model: -> App.User.createRecord()