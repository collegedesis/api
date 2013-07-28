App.SoundCloudWidgetView = Ember.View.extend
  collapsed: true
  template: null # set when instantiated
  track: null # App.SoundCloudTrack object

  didInsertElement: ->
    currentTrackElement = @$().find('iframe')[0]

    widget = SC.Widget(currentTrackElement)

    @set('track.widget', widget)

    widget.bind SC.Widget.Events.READY, =>
      @_play()
      @set('controller.playing', true)

    widget.bind SC.Widget.Events.FINISH, =>
      @_moveToNextTrack()

    widget.bind SC.Widget.Events.PLAY_PROGRESS, (data) =>
      @_showNextTrack(data)

  _moveToNextTrack: ->
    @get('controller').nextSong()

  # fancy animations can happen here.
  _showNextTrack: Ember.K

  _play: -> @get('track.widget').play()

  prepend: ->
    @_insertElementLater ->
      @$().prependTo(document.getElementById('party'))