App.Router.map ->
  # TODO remove these
  @resource "bulletins", ->
    @route "index"
    @route "show", {path: ':slug'}

  @resource 'n', ->
    @route 'story', {path: ':slug'}
    @route 'new'

  # TODO this is legacy. We should
  # remove it eventually and add a 404 route.
  @resource 'news', ->
    @route 'story', {path: ':slug'}

  # simple pages
  @resource 'about', ->
    @route('quick-start')
    @route('represent')
    @route('news')

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