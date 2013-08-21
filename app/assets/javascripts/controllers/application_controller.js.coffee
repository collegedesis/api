App.ApplicationController = Ember.Controller.extend
  # We'll set this property when someone signs in or signs up successfully
  currentUser: null

  # returns bool if the current controller exists.
  isSignedIn: (-> @get("currentUser") != null ).property('currentUser')

  votedBulletinIds: (-> App.session.get("votedBulletinIds")).property('App.session.votes')

  routeChanged: ( ->
    return unless window._gaq
    Em.run.next ->
      page = if window.location.hash.length > 0 then window.location.hash.substring(1) else window.location.pathname
      _gaq.push(['_trackPageview', page])
  ).observes('currentPath')

  numOfOrganizations: null
  numOfUniversities: null
  numOfStates: null

  currentYear: (->
    (new Date).getFullYear()
  ).property()

  firstPage: (->
    {page: '1'}
  ).property()

  homePage: (->
    @get('currentPath') == "index"
  ).property('currentPath')

  newsPage: (->
    if @get('currentPath').match(/n\./) then true else false
  ).property('currentPath')

  leftNavVisible: false
  showNav: ->
    @set('leftNavVisible', !@get('leftNavVisible'))
    @pushBody()

  pushBody: ->
    if @get('leftNavVisible')
      $('.app-content').addClass('push-right');
    else
      $('.app-content').removeClass('push-right')