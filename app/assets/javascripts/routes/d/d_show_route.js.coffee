App.DShowRoute = Ember.Route.extend
  serialize: (model, params) ->
    object = {}
    name = params[0]
    object[name] = model.get('slug')
    return object

  model: (params) ->
    xhr = @get('store').findQuery(App.Organization, {slug: params.slug})
    xhr.then (data) -> return data.get('firstObject')