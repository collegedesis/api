App.OrganizationsShowRoute = Ember.Route.extend
  serialize: (model, params) ->
    object = {}
    name = params[0]
    object[name] = model.get('slug')
    return object

  model: (params) ->
    @get('store').findQuery(App.Organization, {slug: params.slug}).then (data) ->
      debugger
      return data.get('firstObject')