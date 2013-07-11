App.NewsRoute = Ember.Route.extend
  setupController: (controller) ->
    @loadBulletins(1)
  events:
    goToBulletin: (bulletin) ->
      @transitionTo('news.story', bulletin)

  loadBulletins: (page) ->
    controller = @controllerFor('bulletinsIndex')
    controller.set('loading', true)
    xhr = @store.findQuery(App.Bulletin, {page: page})
    xhr.then (data) =>
      controller.set('content', data)
      controller.set('currentPage', parseInt page)
      controller.set('loading', false)