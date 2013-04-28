App.OrganizationsIndexRoute = Ember.Route.extend
  model: -> App.Organization.find()

  setupController: (controller) ->
    controller.set('apiKey', App.session.get('googleMapsApiKey'))
  activate: ->
    url = "//maps.googleapis.com/maps/api/js?key=#{@google_maps_api_key}}&sensor=true"
    # add a map to the dom
    initialize = ->
      mapOptions =
        center: new google.maps.LatLng(-34.397, 150.644)
        zoom: 8
        mapTypeId: google.maps.MapTypeId.ROADMAP

      map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions)

    google.maps.event.addDomListener window, "load", initialize
