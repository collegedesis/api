App.SoundCloudRadioRoute = Ember.Route.extend
  kClientID: "49620079b9efba53d4ae479266b35ad9"

  activate: ->
    SC.initialize({client_id: @get('clientID')})
    $(document).attr('title', 'CollegeDesis - Radio')

  setupController: ->
    controller = @controllerFor('tracks')
    controller._clearViews() # we'll clear the current views

    # revert to default settings of manual properties
    controller.set('hasTracks', true)
    controller.set('loading', true)

    url = @_buildSoundcloudApiUrl @get('kClientID'), @get('groupID')
    trackObjects = Em.A() # to collect track Objects in
    xhr = $.getJSON url, (tracksJSONObjects) =>
      @_shuffleTrackObjects(tracksJSONObjects)

      $(tracksJSONObjects).each (index, item) ->
        # create an Ember Object with the json and create an array of them
        trackObject = App.SoundCloudTrack.create({json: item, id: index})
        trackObjects.pushObject(trackObject)

      # tune into the channel with the emberObjects
      controller.set('content', trackObjects)
      controller.tuneIntoChannel()

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

  _buildSoundcloudApiUrl: (clientID, groupID) ->
    "https://api.soundcloud.com/groups/" + groupID + "/tracks.json?client_id=" + clientID + "&limit=50"

App.RadioIndexRoute = Ember.Route.extend
  redirect: -> @transitionTo('radio.mashup')

# TODO: Document how to retrieve these Group IDs
App.RadioMashupRoute = App.SoundCloudRadioRoute.extend
  groupID: "77839" # soundcloud.com/groups/collegedesis
App.RadioBhangraRoute = App.SoundCloudRadioRoute.extend
  groupID: "124626" # soundcloud.com/groups/collegedesis-bhangra-radio
App.RadioAcappellaRoute = App.SoundCloudRadioRoute.extend
  groupID: "124320" # soundcloud.com/groups/south-asian-a-cappella-radio/