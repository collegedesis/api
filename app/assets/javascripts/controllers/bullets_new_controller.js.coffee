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
    bulletin = @get('content')
    bulletin.removeObserver('id', this, '_createdBulletin')
    @transitionToRoute("bulletins.show", bulletin)

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

  setPost: -> @set('bulletin_type', 1)
  setLink: -> @set('bulletin_type', 2)