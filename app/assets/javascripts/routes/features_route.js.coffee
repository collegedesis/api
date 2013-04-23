App.FeaturesRoute = Ember.Route.extend
  model: ->
    url = "https://api.github.com/repos/collegedesis/collegedesis.com/issues?labels=feature"
    content = Em.A()
    $.getJSON url, (data) ->
      $(data).each (index, item) -> content.pushObject(item)
    return content