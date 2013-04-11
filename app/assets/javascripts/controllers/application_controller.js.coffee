App.ApplicationController = Ember.Controller.extend
  # We'll set this property when someone signs in or signs up successfully
  currentUser: null

  # returns bool if the current controller exists.
  isSignedIn: (-> @get("currentUser") != null ).property('currentUser')

  votedBulletinIds: (-> App.session.get("votedBulletinIds")).property('App.session.votes')

  routeChanged: ( ->
    return unless window._gaq
    Em.run.next ->
      _gaq.push(['_trackPageview'])
  ).observes('currentPath')