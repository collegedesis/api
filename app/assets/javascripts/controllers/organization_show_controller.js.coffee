App.OrganizationsShowController = Ember.ObjectController.extend
  needs: ['application']

  # fields for application
  location: null
  obsession: null
  communication: null
  largestChat: null
  why: null

  applied: false
  working: false
  collegedesis: (->
    @get('name') == "CollegeDesis"
  ).property('name')

  apply: ->
    @set('working', false)
    # TODO open this feature up for all orgs eventually
    # id = @get('id')
    id = 275
    # This is the `id` for CollegeDesis in our production db.
    # We've monkeypatched this in dev as well, but it is very obviously
    # a short term solution. [mehulkar]
    url = "/organizations/#{id}/apply"
    data = {
      application: {
        location: @get('location')
        obsession: @get('obsession')
        communication: @get('communication')
        largestChat: @get('largestChat')
        why: @get('why')
      }
    }
    $.post url, data, =>
      @set('working', false)
      @set('applied', true)