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

  # filter actions
  selectState: (state) ->
    @get('selectedStates').push(state)
    @_incrementQueries()

  unselectState: (state) ->
    newStates = @get('selectedStates').without(state)
    @set('selectedStates', newStates)
    @_incrementQueries()

  # search
  search: -> @_incrementQueries()

  organizations: (->
    @set('loading', true)
    promise = @makeAPICall()
    promise.then => @set('loading', false)
    return promise
  ).property('queries')

  makeAPICall: ->
    states = @get('selectedStates')
    param = @get('searchParam')
    query = {
      states: states,
      param: param
    }
    return @store.findQuery(App.Organization, {query: query})

  numOfUniversities: (->
    if @get('selectedStates.length')
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
    if @get('selectedStates.length')
      @get('organizations.length')
    else
      @get('controllers.application.numOfOrganizations')
  ).property('organizations.length', 'selectedStates.length')

  # call `_incrementQueries` whenever you want to watch
  # make an api call based on a user interaction
  # when the query property changes, we recalculate organizations
  # by making an api call
  queries: 0
  _incrementQueries: ->
    currentLength = @get('selectedStates.length')
    window.setTimeout =>
      if currentLength == @get('selectedStates.length')
        @set('queries', @get('queries') + 1)
    , 200

  _resetQueries: ->
    @set('queries', 0)
