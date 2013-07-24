App.DSettingsRoute = Ember.Route.extend
  redirect: (model) ->
    user = @controllerFor('application').get('currentUser')
    if !user
      @transitionTo('d.show', model)
    else if user && !user.adminOf(model.get('id'))
      @transitionTo('d.show', model)


  serialize: (model, params) ->
    object = {}
    name = params[0]
    object[name] = model.get('slug')
    return object

  model: (params) ->
    console.log 'model'
    @get('store').findQuery(App.Organization, {slug: params.slug}).then (data) ->
      return data.get('firstObject')

  deactivate: ->
    org = @get('controller.content')
    org.rollback() if org.get('isDirty')