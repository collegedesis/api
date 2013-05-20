App.RadioController = Ember.Controller.extend
  needs: ['tracks', 'application']

  hasTracks: (->
    @get("controllers.tracks.hasTracks")
  ).property('controllers.tracks.hasTracks')

  readyToPlay: (->
    @get 'controllers.tracks.readyToPlay'
  ).property('controllers.tracks.readyToPlay')

  loading: (->
    @get('controllers.tracks.loading')
  ).property('controllers.tracks.loading')

  nextTrack: (->
    @get 'controllers.tracks.nextTrack'
  ).property('controllers.tracks.nextTrack')

  currentTrack: (->
    @get 'controllers.tracks.currentTrack'
  ).property('controllers.tracks.currentTrack')

  nextSong: -> @get('controllers.tracks').nextSong()

  channel: (->
    name = @get('controllers.application.currentPath').split('.')[1].capitalize()
    if name == "Acappella" then return "A Cappella" else return name
  ).property('controllers.application.currentPath')

  groupURL: (->
    url = "https://soundcloud.com/groups/"
    switch @get("channel")
      when "Bhangra"
        url + "collegedesis"
      when "Mashup"
        url + "collegedesis-bhangra-radio"
      when "A Cappella"
        url + "south-asian-a-cappella-radio"
  ).property('channel')