App.PartyRoute = Ember.Route.extend

  activate: ->
    SC.initialize({client_id: '49620079b9efba53d4ae479266b35ad9'})

  setupController: (controller) ->
    # get group info
    url = "http://soundcloud.com/groups/collegedesis"
    SC.get "/resolve", url: url, (data) =>
      controller.set('groupInfo', data)

    # get the tracks
    content = Em.A()
    url = 'https://api.soundcloud.com/groups/77839/tracks.json?client_id=49620079b9efba53d4ae479266b35ad9&limit=200'
    xhr = $.getJSON url, (tracks) =>
      # fisherYates algorithm to shuffle the array
      i = tracks.length
      return false  if i is 0
      while --i
        j = Math.floor(Math.random() * (i + 1))
        tempi = tracks[i]
        tempj = tracks[j]
        tracks[i] = tempj
        tracks[j] = tempi

      $(tracks).each (index, item) ->
        trackObject = App.SoundCloudTrack.create
          json: item
          id: index
        content.pushObject(trackObject)

    xhr.done ->
      controller.set 'content', content
      controller.set 'currentTrack', content.objectAt(0)
      controller.set 'nextTrack', content.objectAt(1)

      controller.get('currentTrack').load()
      controller.get('nextTrack').load()