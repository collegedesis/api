App.MapController = Ember.ArrayController.extend
  needs: ['application']

  loading: false

  init: ->
    @set('loading', true)
    @_super()

  selectedStates: Em.A()

  selectedOrgs: (->
    @set('loading', true)
    states = @get('selectedStates')
    xhr = @store.findQuery(App.Organization, {states: states})
    xhr.then => @set('loading', false)
    return xhr
  ).property('queries')

  numOfUniversities: (->
    @get('selectedOrgs').mapProperty('university_name').uniq().get('length')
  ).property('selectedOrgs.@each.university')

  numOfStates: (->
    if @get('selectedStates.length') == 0
      @get('controllers.application.numOfStates')
    else
      @get('selectedStates.length')
  ).property('queries', 'controllers.application.numOfStates')

  selectState: (state) ->
    @get('selectedStates').push(state)
    @_incrementQueries()

  unselectState: (state) ->
    newStates = @get('selectedStates').without(state)
    @set('selectedStates', newStates)
    @_incrementQueries()

  # For some reason, `selectedOrgs` doesn't fire
  # when selectedStates changes. I've tried watching
  # `selectedStates.@each` and `selectedStates.length`
  # To get around this, I'm incrementing a counter
  # every time we select or unselect a state
  # and using that to recalculate selectedOrgs
  # TODO this should be fixed
  # - mehulkar
  queries: 0
  _incrementQueries: ->
    @set('queries', @get('queries') + 1)