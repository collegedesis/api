App.BulletinsNewController = Ember.ObjectController.extend

  submit: ->
    @get('content').addObserver('id', this, '_createdBulletin')
    @get("store").commit()

  _createdBulletin: ->
    @get("content").removeObserver('id', this, '_createdBulletin')
    @transitionToRoute("bulletins.index")

  bulletinTypes: (->
    return [
      Ember.Object.create({name: "Link", value: 2}),
      Ember.Object.create({name: "Post", value: 1}),
    ]
  ).property()