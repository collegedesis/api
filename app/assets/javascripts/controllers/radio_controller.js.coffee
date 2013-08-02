App.RadioController = Ember.ArrayController.extend
  needs: ['application']
  kClientID: "49620079b9efba53d4ae479266b35ad9"
  # Follow the guide here to resolve a GroupID from the URL
  # http://developers.soundcloud.com/docs/api/guide#resolving
  kMashupGroupID: "77839"  # soundcloud.com/groups/collegedesis
  kBhangraGroupID: "124626" # soundcloud.com/groups/collegedesis-bhangra-radio
  kAcappellaGroupID: "124320" # soundcloud.com/groups/south-asian-a-cappella-radio
  kIndependentGroupID: "126422" # soundcloud.com/groups/collegedesis-independent

  currentGroupId: "77839" # starts as the mashup group

  # the radio gets initialized when the user hits play for the first time
  initialized: false

  # used for showing spinner
  loading: false

  # keep track of all the widgets we're adding to the DOM
  # so we can clear them
  viewObjects: Em.A()

  initializeRadioWithChannel: (groupId) ->
    # tell the UI that we're working
    @set('loading', true)

    # clear all the soundcloud widgets currently in the dom
    @_clearViews()

    # prepare the SC client with API authorization
    SC.initialize({client_id: @get('kClientID')})

    # an array to collect track objects in
    trackObjects = Em.A()

    # the URL for the currentGroup including the kClientID parameter
    url = @get('soundcloudAPIUrl')

    xhr = $.getJSON url, (jsonTracks) =>
      @_shuffleTrackObjects(jsonTracks)

      # create an Ember Object with each jsonTrack
      $(jsonTracks).each (index, json) ->
        track = App.SoundCloudTrack.create
          id: index
          json: json

        trackObjects.pushObject(track)

      # set the content of the controller with the track
      @set('content', trackObjects)

      # set the current and next tracks
      @set('currentTrack', @get('content').objectAt(0))
      @set('nextTrack', @get('content').objectAt(1))

      # load the first track
      @get('currentTrack').load()

      # set the initialized to true
      @set('initialized', true)

  # currently playing sound. this is a App.SoundCloudTrack instance
  # and has a handle to three things as properties:
  # 1. the soundcloud widget object,
  # 2. and the actual html for the widget
  # 3. the json from soundcloud
  currentTrack: null
  nextTrack: null

  # triggered when the current track finishes or when the user hits next
  nextSong: ->
    # next track should already be loaded right now
    # so all we have to do is create the view object and insert it into the dom
    @set('loading', true)
    @set('currentTrack', @get('nextTrack'))
    @set('nextTrack', null)

  # insert the currentTrack into the DOM
  # it will start playing when then view is inserted and the widget is ready
  # see the App.SoundCloudWidgetView definition
  insertCurrentTrack: (->
    if @get('currentTrack.isLoaded') && !@get('currentTrack.inDom')

      view = App.SoundCloudWidgetView.create
        template: Ember.Handlebars.compile @get('currentTrack.embedHtml')
        track: @get('currentTrack')
        controller: @

      @set('currentTrack.inDom', true)

      Em.run.next => view.prepend()

  ).observes('nextTrack.isLoaded', 'currentTrack.isLoaded')

  # load the html for another track when the current track changes,
  # so we can queue it up
  loadAnotherTrack: (->
    if @get('nextTrack') == null
      console.log 'queuing the next track'
      id = @get('currentTrack.id')
      newTrack = @get('content').objectAt(id + 1)
      @set('nextTrack', newTrack)
      @get('nextTrack').load()
  ).observes('currentTrack.id', 'nextTrack')

  # use this to change the UI for play/pause button
  playing: false

  # triggered by play/pause button in UI
  play: ->
    @_animiteTitle()
    if @get('initialized')
      @get('currentTrack.widget').play()
      @set('playing', true) # for the UI
      @set('loading', false) # for the UI
    else
      @initializeRadioWithChannel @get('currentGroupId')

  pause: ->
    @get('currentTrack.widget').pause()
    @set('playing', false) # for the UI

  # we clear views when moving into a new channel
  _clearViews: -> @get('viewObjects').forEach (view) -> view.remove()

  _animiteTitle: ->
    $('.now-playing').removeClass('fadeInUp')
    Em.run.next -> $('.now-playing').addClass('fadeInUp')

  # constructs the url for the soundcloud group where we send the network request to fetch tracks
  soundcloudAPIUrl: (->
    groupID = @get('currentGroupId')
    clientID = @get('kClientID')
    "https://api.soundcloud.com/groups/#{groupID}/tracks.json?client_id=#{clientID}&limit=50"
  ).property('currentGroupId', 'kClientID')

  # fisherYates algorithm to shuffle an array
  _shuffleTrackObjects: (tracks) ->
    i = tracks.length
    return false  if i is 0
    while --i
      j = Math.floor(Math.random() * (i + 1))
      tempi = tracks[i]
      tempj = tracks[j]
      tracks[i] = tempj
      tracks[j] = tempi