App.AboutRoute = Ember.Route.extend
  redirect: ->
    App.Organization.find({slug: 'collegedesis'}).then (data) =>
      cd = data.get('firstObject')
      @transitionTo('d.show', cd)