App.BulletinsNewController = Ember.ObjectController.extend

  submit: ->
    @get("store").commit()
    @transitionToRoute("bulletins.index")

  bulletinTypes: (->
    return [
      Ember.Object.create({name: "Link", value: 2}),
      Ember.Object.create({name: "Post", value: 1}),
    ]
  ).property()