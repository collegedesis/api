App.NStoryView = Ember.View.extend
  jumpToComment: -> $('.bulletin-comments textarea').focus()

  controllerContentDidChange: (->
    $('body').scrollTop(0)
  ).observes('controller.content')