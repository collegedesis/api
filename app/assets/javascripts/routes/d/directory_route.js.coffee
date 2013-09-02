App.DirectoryRoute = Ember.Route.extend
  activate: -> $(document).attr('title', 'Directory - CollegeDesis')

App.DIndexRoute = Ember.Route.extend
  redirect: -> @transitionTo('directory')