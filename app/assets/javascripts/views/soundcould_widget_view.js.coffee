App.SoundCloudWidgetView = Ember.View.extend
  collapsed: true
  template: null # set when instantiated
  track: null # App.SoundCloudTrack object

  didInsertElement: ->
    currentTrackElement = @$().find('iframe')[0]

    widget = SC.Widget(currentTrackElement)

    @set('track.widget', widget)
    @get('controller.viewObjects').pushObject(@)

    widget.bind SC.Widget.Events.READY, =>
      @get('controller').play()

    widget.bind SC.Widget.Events.FINISH, =>
      @_moveToNextTrack()

  _moveToNextTrack: ->
    @get('controller').nextSong()

  prepend: ->
    @_insertElementLater ->
      @$().prependTo(document.getElementById('party'))