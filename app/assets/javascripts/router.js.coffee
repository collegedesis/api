App.Router.map ->
  @resource "bulletins", ->
    @route "new"
    @route "show", {path: ':slug'}

  @route 'news', {path: 'news/:page'}

  # simple pages
  @resource 'about', ->
    @route('intro')
    @route('contact')

  @route 'login', {path: 'login'}

  @resource "organizations", ->
    @route "index"
    @route "show", {path: ':slug'}

  @resource "users", ->
    @route "show", {path: ':user_id'}
    @route 'new', {path: 'signup'}

  # using APIs
  @route('features', {path: 'upcoming'})

  @resource "radio", ->
    @route "acappella"
    @route "mashup"
    @route "bhangra"
    @route "independent"

  # redirections
  @route('reps')