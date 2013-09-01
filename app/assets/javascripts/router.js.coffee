App.Router.map ->
  @route 'news'
  @resource 'n', ->
    @route 'story', {path: ':slug'}
    @route 'submit'

  # simple pages
  @route 'about'

  @route 'login', {path: 'login'}

  @route 'directory'
  @resource 'd', ->
    @route 'show', {path: ':slug'}

  @resource 'organizations', ->
    @route 'index'
    @route 'show', {path: ':slug'}

  @resource 'users', ->
    @route 'new', {path: 'join'}
    @route 'me'

  @route('applicationresponse', {path: 'application-response/:id'} )