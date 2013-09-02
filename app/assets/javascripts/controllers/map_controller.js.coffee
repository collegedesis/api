App.MapController = Ember.ArrayController.extend
  needs: ['application']

  loading: false

  init: ->
    @set('loading', true)
    @_super()

  selectedStates: Em.A()
  searchParam: null

  clearResults: ->
    @set('searchParam', null)
    @set('selectedStates', Em.A())
    @_resetQueries()

  ## Takes an array of 2 letter abbreviations of US states
  updateSelectedStates: (selected) ->
    @set('selectedStates', selected)
    @_incrementQueries()
    @transitionToRoute('directory')

  search: -> @_incrementQueries()

  numOfUniversities: (->
    if @get('selectedStates.length') or @get('searchParam.length')
      @get('organizations').mapProperty('university_name').uniq().get('length')
    else
      @get('controllers.application.numOfUniversities')
  ).property('selectedStates.length', 'organizations.@each.university_name', 'controllers.application.numOfUniversities')

  numOfStates: (->
    if @get('selectedStates.length') == 0
      @get('controllers.application.numOfStates')
    else
      @get('selectedStates.length')
  ).property('queries', 'controllers.application.numOfStates')

  numOfOrganizations: (->
    if @get('selectedStates.length') or @get('searchParam.length')
      @get('organizations.length')
    else
      @get('controllers.application.numOfOrganizations')
  ).property('organizations.length', 'selectedStates.length')

  # call `_incrementQueries` to make an api call
  organizations: (->
    @set('loading', true)
    promise = @makeAPICall()
    promise.then => @set('loading', false)
    return promise
  ).property('queries')

  # when the query property changes, we recalculate organizations
  # by making an api call
  queries: 0
  _incrementQueries: ->
    currentLength = @get('selectedStates.length')
    window.setTimeout =>
      if currentLength == @get('selectedStates.length')
        @set('queries', @get('queries') + 1)
    , 200

  _resetQueries: -> @set('queries', 0)

  makeAPICall: ->
    states = @get('selectedStates')
    param = @get('searchParam')
    query = { states: states, param: param }
    return @store.findQuery(App.Organization, {q: query})
