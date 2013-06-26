App.Router.map ->
  @resource "bulletins", ->
    @route "index"
    @route "new"
    @route "show", {path: ':slug'}

  @resource 'news', ->
    @route 'page', {path: ':page'}

  # simple pages
  @resource 'about', ->
    @route('intro')
    @route('contact')
    @route('website')
    @route('goals')
    @route('reps')

  @route 'login', {path: 'login'}

  @resource "organizations", ->
    @route "index"
    @route "show", {path: ':slug'}
    @route "settings", {path: ":slug/settings"}

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