App.RadioController = Ember.ArrayController.extend
  content: null # an array of App.SoundCloudTrack objects

  currentTrack: null
  nextTrack: null

  groupInfo: null

  readyToPlay: (->
    @get('currentTrack.isLoaded') && @get('nextTrack.isLoaded')
  ).property('currentTrack.isLoaded', 'nextTrack.isLoaded')

  createAndInsertWidget: (->
    if @get('currentTrack.isLoaded') && !@get('currentTrack.inDom')
      view = App.SoundCloudWidgetView.create(
        template: Ember.Handlebars.compile @get('currentTrack.oEmbed.html')
        track: @get('currentTrack')
        controller: @
      )
      Em.run.next ->
        view.prepend()
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