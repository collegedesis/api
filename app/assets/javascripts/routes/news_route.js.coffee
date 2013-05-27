App.NewsRoute = Ember.Route.extend

  events:
    goToBulletin: (bulletin) ->
      @transitionTo('bulletins.show', bulletin)

    write: -> @transitionTo('bulletins.new')

  setupController: (controller, params) ->
    @loadBulletins(params.page)

  activate: ->
    $(document).attr('title', 'CollegeDesis - News')

  redirect: (params) ->
    @transitionTo('news', {page: '1'}) if !params

  serialize: (model, params) -> return model

  loadBulletins: (page) ->
    controller = @controllerFor('bulletinsIndex')
    @set('loading', true)
    xhr = @store.findQuery(App.Bulletin, {page: page})
    xhr.then (data) =>
      controller.set('content', data)
      controller.set('currentPage', parseInt page)
      controller.set('loading', false)