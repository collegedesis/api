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