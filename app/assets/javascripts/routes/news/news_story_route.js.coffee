App.NewsStoryRoute = Ember.Route.extend
  serialize: (model, params) ->
    object = {}
    name = params[0]
    object[name] = model.get('slug')
    return object

  model: (params) ->
    @get('store').findQuery(App.Bulletin, {slug: params.slug}).then (data) ->
      return data.get('firstObject')