App.NStoryView = Ember.View.extend
  classNames: ['bulletin']
  jumpToComment: -> $('.bulletin-comments textarea').focus()

  controllerContentDidChange: (->
    $('body').scrollTop(0)
  ).observes('controller.content')