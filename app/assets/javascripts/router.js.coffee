App.Router.map ->
  @resource "bulletins", ->
    @route "index"
    @route "new"
    @route "show", {path: ':slug'}

  @resource 'news', ->
    @route 'page', {path: ':page'}
    @route 'story', {path: ':slug'}

  # simple pages
  @resource 'about', ->
    @route('intro')
    @route('contact')
    @route('website')
    @route('goals')

  @route 'login', {path: 'login'}

  @resource "organizations", ->
    @route "index"
    @route "show", {path: ':slug'}
    @route "settings", {path: ":slug/settings"}

  @resource "users", ->
    @route 'new', {path: 'signup'}
    @route 'me'

  @resource "radio", ->
    @route "acappella"
    @route "mashup"
    @route "bhangra"
    @route "independent"

  @route('applicationresponse', {path: 'application-response/:id'} )