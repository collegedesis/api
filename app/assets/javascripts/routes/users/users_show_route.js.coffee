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
    controller.set('loading', true)
    user = controller.get('content')
    bulletins = App.Organization.find()
    bulletins.then (data) =>
      @controllerFor('organizationsIndex').set('content', data)
      setTimeout =>
        controller.set('loading', false)
      , 2500

  deactivate: ->
    App.session.set('messages', null)
    @get('controller.content.memberships').forEach (item) ->
      item.deleteRecord() if item.get('isNew')