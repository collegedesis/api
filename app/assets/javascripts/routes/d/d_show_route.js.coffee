App.DShowRoute = Ember.Route.extend
  serialize: (model, params) ->
    object = {}
    name = params[0]
    object[name] = model.get('slug')
    return object

  model: (params) ->
    xhr = @get('store').findQuery(App.Organization, {slug: params.slug})
    xhr.then (data) -> return data.get('firstObject')

  setupController: (controller, model) ->
    controller.set('content', model)
    # TODO since we have two different serializers for organizations,
    # sometimes memberships and bulletins are not loaded.
    # we could do some kind of check here but simply reloading the organization
    # is fine for now.
    model.reload()
