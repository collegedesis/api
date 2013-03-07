CollegeDesis.BulletinsNewController = Ember.ObjectController.extend

  submit: ->
    @get("store").commit()
    @transitionToRoute("bulletins.index")

  isPost: (-> @get('bulletin_type') == 1 ).property('bulletin_type')
  isLink: (-> @get('bulletin_type') == 2 ).property('bulletin_type')


  bulletinTypes: (->
    return [
      Ember.Object.create({name: "Link", value: 2}),
      Ember.Object.create({name: "Post", value: 1}),
    ]
  ).property()