App.NStoryRoute = Ember.Route.extend
  serialize: (model, params) ->
    object = {}
    name = params[0]
    object[name] = model.get('slug')
    return object

  model: (params) ->
    @get('store').findQuery(App.Bulletin, {slug: params.slug}).then (data) ->
      bulletin = data.get('firstObject')
      return bulletin

  setupController: (controller, model) ->
    if model
      # create a view on the record
      view = App.View.createRecord({
        viewableId: model.get('id'),
        viewableType: 'Bulletin'
      })
      view.save()
    controller.set('model', model)