App.IndexRoute = Ember.Route.extend
  redirect: ->
    if @controllerFor('application').get('currentUser')
      @transitionTo('news.page', {page: '1'})