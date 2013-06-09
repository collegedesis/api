App.TracksController = Ember.ArrayController.extend

  content: null # an array of App.SoundCloudTrack objects
  viewObjects: Em.A() # an array of views currently inDOM
  currentTrack: null
  nextTrack: null

  # manually set these properties when entering a route
  hasTracks: true
  loading: false

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
        template: Ember.Handlebars.compile @get('currentTrack.oEmbed.html')
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
  _clearViews: ->
    @get('viewObjects').forEach (view) -> view.remove()

  currentTrackChanged: (->
    title = @get("currentTrack.json.title")
    $(document).attr('title', "#{title} - CollegeDesis Radio")
  ).observes('currentTrack')