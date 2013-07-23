App.MapController = Ember.ArrayController.extend
  needs: ['application']

  loading: false

  init: ->
    @set('loading', true)
    @_super()

  selectedStates: Em.A()
  searchParam: null

  # filter actions
  selectState: (state) ->
    @get('selectedStates').push(state)
    @_incrementQueries()

  unselectState: (state) ->
    newStates = @get('selectedStates').without(state)
    @set('selectedStates', newStates)
    @_incrementQueries()

  # search
  searchParamDidChange: (->
    @_incrementQueries()
  ).observes('searchParam')

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
    if @get('organizations')
      @get('organizations').mapProperty('university_name').uniq().get('length')
  ).property('organizations.@each.university')

  numOfStates: (->
    if @get('selectedStates.length') == 0
      @get('controllers.application.numOfStates')
    else
      @get('selectedStates.length')
  ).property('queries', 'controllers.application.numOfStates')

  numOfOrganizations: (->
    if @get('organizations.length')
      @get('organizations.length')
    else
      @get('controllers.application.numOfOrganizations')
  ).property('organizations.length')

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
