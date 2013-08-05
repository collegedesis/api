App.BaseNewsRoute = Ember.Route.extend
  setupController: (controller) ->
    @loadBulletins(1)

  events:
    goToBulletin: (bulletin) ->
      @transitionTo('n.story', bulletin)

  # TODO remove bulletinsIndex controller and just use the
  # newsController.
  loadBulletins: (page) ->
    controller = @controllerFor('bulletinsIndex')
    controller.set('loading', true)
    xhr = @store.findQuery(App.Bulletin, {page: page})
    xhr.then (data) =>
      controller.set('content', data)
      controller.set('currentPage', parseInt page)
      controller.set('loading', false)

App.NewsRoute = App.BaseNewsRoute.extend()
App.NRoute = App.BaseNewsRoute.extend()

# This exists so we the main news page url is /news
App.NIndexRoute = Ember.Route.extend
  redirect: -> @transitionTo('news')