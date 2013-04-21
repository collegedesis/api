App.Router.map ->
  @route('features', {path: 'upcoming'})
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
  @route('radio')

App.FeaturesRoute = Ember.Route.extend
  model: ->
    url = "https://api.github.com/repos/collegedesis/collegedesis.com/issues?labels=feature"
    content = Em.A()
    $.getJSON url, (data) ->
      $(data).each (index, item) -> content.pushObject(item)
    return content

App.LoginRoute = Ember.Route.extend
  deactivate: ->
    App.session.set("messages", null)

App.IndexRoute = Ember.Route.extend
  events:
    goToBulletin: (bulletin) ->
      @transitionTo('bulletins.show', bulletin)
      # if bulletin.get('isPost')
      #   @transitionTo('bulletins.show', bulletin)
      # else
      #   window.open(bulletin.get('url'))
    write: -> @transitionTo('bulletins.new')

  setupController: (controller) ->
    xhr = $.get '/info', (data) ->
      return data
    xhr.done (data) ->
      controller.set('numOfOrganizations', data.orgs)
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
  deactivate: ->
    App.session.set('messages', null)
    @get('controller.content.memberships').forEach (item) ->
      item.deleteRecord() if item.get('isNew')

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

  model: (params) ->
    @get('store').findQuery(App.Bulletin, {slug: params.slug}).then (data) ->
      return data.get('firstObject')

App.BulletinsNewRoute = Ember.Route.extend
  redirect: (model) ->
    user = @controllerFor('application').get('currentUser')
    if user
     if !user.get('approved')
      App.session.set('messages', 'Add a Membership to post!')
      @transitionTo('users.show', user)
      model.deleteRecord() if model.get('isNew')
    else
      App.session.set('messages', 'You need to be logged in to post!')
      @transitionTo('login')
      model.deleteRecord() if model.get('isNew')

  model: -> App.Bulletin.createRecord({bulletin_type: 1})

  exit: -> @get('controller.content').deleteRecord() if @get('controller.content.isNew')

App.NewUserRoute = Ember.Route.extend
  model: -> App.User.createRecord()