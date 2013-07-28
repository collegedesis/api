App.RadioController = Ember.ArrayController.extend
  needs: ['application']
  kClientID: "49620079b9efba53d4ae479266b35ad9"
  # Follow the guide here to resolve a GroupID from the URL
  # http://developers.soundcloud.com/docs/api/guide#resolving
  kMashupGroupID: "77839"  # soundcloud.com/groups/collegedesis
  kBhangraGroupID: "124626" # soundcloud.com/groups/collegedesis-bhangra-radio
  kAcappellaGroupID: "124320" # soundcloud.com/groups/south-asian-a-cappella-radio
  kIndependentGroupID: "126422" # soundcloud.com/groups/collegedesis-independent

  currentGroupId: null
  defaultGroupId: (-> @get('kMashupGroupID') ).property()

  initializeRadio: ->
    SC.initialize({client_id: @get('clientID')})

    @set('currentGroupId', @get('defaultGroupId')) if !@get('currentGroupId')
    @set('hasTracks', true)
    @set('loading', true)

    url = @get('soundcloudAPIUrl')
    trackObjects = Em.A() # to collect track Objects in

    xhr = $.getJSON url, (tracksJSONObjects) =>
      @_shuffleTrackObjects(tracksJSONObjects)

      $(tracksJSONObjects).each (index, item) ->
        # create an Ember Object with the json and create an array of them
        trackObject = App.SoundCloudTrack.create({json: item, id: index})
        trackObjects.pushObject(trackObject)

      # tune into the channel with the emberObjects
      @set('content', trackObjects)
      @tuneIntoChannel()


  content: null # an array of App.SoundCloudTrack objects
  viewObjects: Em.A() # an array of views currently inDOM
  currentTrack: null
  nextTrack: null

  # manually set these properties when entering a route
  hasTracks: true
  loading: false
  playing: false

  readyToPlay: (->
    @get('hasTracks') && @get('currentTrack.isLoaded') && @get('nextTrack.isLoaded')
  ).property('currentTrack.isLoaded', 'nextTrack.isLoaded', 'hasTracks')


  # gets the currentTrack, loads it and inserts it into the DOM
  # this fires every time a new track is loaded.
  # a new track is loaded every time nextTrack changes
  # nextTrack changes when it is set to null
  # next track is set to null when the the currentTrack finishes
  createAndInsertWidget: (->
    if @get('currentTrack.isLoaded') && !@get('currentTrack.inDom')
      view = App.SoundCloudWidgetView.create(
        template: Ember.Handlebars.compile @get('currentTrack.embedHtml')
        track: @get('currentTrack')
        controller: @
      )
      Em.run.next =>
        view.prepend()
        @get('viewObjects').pushObject(view)
      @set('currentTrack.inDom', true)
  ).observes('readyToPlay')

  # when the next track is null, we load the next available track
  # and set it as the next track
  loadNewTrack: (->
    if @get('nextTrack') == null
      track = @get('content').objectAt(@get('currentTrack.id') + 1)
      track.load()
      @set('nextTrack', track)
  ).observes('nextTrack')

  # triggered when the current track finishes
  # or when the user hits next
  nextSong: ->
    @set('currentTrack', @get('nextTrack'))
    @set('nextTrack', null)

  togglePlay: ->
    @get('currentTrack.widget').toggle()
    @set('playing', !@get('playing'))

  # this is called after the xhr returns
  tuneIntoChannel: ->
    content = @get('content')

    if content.length
      @set 'currentTrack', content.objectAt(0)
      @set 'nextTrack', content.objectAt(1)
      @get('currentTrack').load()
      @get('nextTrack').load()
    else
      @set('hasTracks', false)

    # we are no longer loading
    @set('loading', false)

  # we clear views when moving into a new channel
  _clearViews: -> @get('viewObjects').forEach (view) -> view.remove()

  soundcloudAPIUrl: (->
    groupID = @get('currentGroupId')
    clientID = @get('kClientID')
    "https://api.soundcloud.com/groups/#{groupID}/tracks.json?client_id=#{clientID}&limit=50"
  ).property('currentGroupId', 'kClientID')

  # fisherYates algorithm to shuffle the array
  _shuffleTrackObjects: (tracks) ->
    i = tracks.length
    return false  if i is 0
    while --i
      j = Math.floor(Math.random() * (i + 1))
      tempi = tracks[i]
      tempj = tracks[j]
      tracks[i] = tempj
      tracks[j] = tempi