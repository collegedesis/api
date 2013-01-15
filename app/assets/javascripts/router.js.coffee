CollegeDesis.Router.map ->
  @route("bulletins")
  @route("store")
  @route("calendar")
  @resource "bulletins", ->
    @route "new"
    @route "show", {path: ':bulletin_slug'}


CollegeDesis.BulletinsIndexRoute = Ember.Route.extend
  events: 
    goToBulletin: (bulletin) ->
      @transitionTo('bulletins.show', bulletin)
  model: ->
    return CollegeDesis.Bulletin.find()

CollegeDesis.BulletinsShowRoute = Ember.Route.extend
  serialize: (model, params) ->
    object = {}
    name = params[0]
    object[name] = Em.String.dasherize model.get('title')
    return object

  deserialize: (params) ->
    slug = params['bulletin_slug']
    title = slug.split('-').join(' ')
    bulletins = CollegeDesis.Bulletin.find({title: title})