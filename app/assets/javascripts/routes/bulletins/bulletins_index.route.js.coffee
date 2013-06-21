App.BulletinsIndexRoute = Ember.Route.extend
  redirect: -> @transitionTo('news.page', {page: 1})