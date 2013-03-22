App.BulletinsNewController = Ember.ObjectController.extend
  showPreview: false

  preview: ->
    @set('showPreview', !@get('showPreview'))

  showingPreview: (-> @get("showPreview")).property('showPreview')

  submit: ->
    @get('content').addObserver('id', this, '_createdBulletin')
    if !@get('errors')
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

  errors: (->
    val = true
    if @get('bulletin_type') == 2
      if @get('title') && @get('url') && @get('validUrl') then val = false else val = true
    else if @get('bulletin_type') == 1
      if @get('title') && @get('body') then val = false else val = true
    return val
  ).property('title', 'url', 'body', 'validUrl')

  validUrl: (->
    @get('url').match(/^https?:\/\/.+\..+/) if @get('url')?
  ).property('url')