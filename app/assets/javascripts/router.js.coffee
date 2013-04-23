App.Router.map ->
  @resource "bulletins", ->
    @route "new"
    @route "show", {path: ':slug'}

  # simple pages
  @route("about")

  @route 'login', {path: 'login'}

  @resource "organizations", ->
    @route "index"
    @route "show", {path: ':slug'}

  @resource "users", ->
    @route "show", {path: ':user_id'}
    @route 'new', {path: 'signup'}

  # using APIs
  @route('features', {path: 'upcoming'})
  @route('radio')

  # redirections
  @route('reps')