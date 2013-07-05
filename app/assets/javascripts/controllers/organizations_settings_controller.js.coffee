App.OrganizationsSettingsController = Ember.ObjectController.extend

  needs: ['application', 'organizationsShow']

  currentUser: (->
    @get('controllers.application.currentUser')
  ).property('controllers.application.currentUser')

  currentUserIsAdmin: (->
    if this.get('currentUser')
      @get('currentUser').adminOf @get('id')
  ).property('currentUser.memberships.@each.membership_type', 'id')

  currentUserIsMember: (->
    if @get('currentUser')
      @get('currentUser').memberOf @get('id')
  ).property('currentUser.memberships.@each.membership_type', 'id')

  save: ->
    if !@get('errors')
      @get('store').commit()

  errors: (->
    arr = Em.A()
    arr.push('slug is invalid') if !@get('slugisValid')
    arr.push('twitter is invalid') if !@get('twitterIsValid')
    arr.push('facebook is invalid') if !@get('facebookIsValid')
    arr.push('youtube is invalid') if !@get("youTubeIsValid")
    return arr
  ).property('slugisValid', 'twitterIsValid', 'facebookIsValid', 'youTubeIsValid')

  slugisValid: (->
    @get('slug') && !@_containsSpaces @get('slug')
  ).property('slug')

  twitterIsValid: (->
    if @get('twitter')
      !@_containsSpaces @get('twitter')
    else
      true
  ).property('twitter')

  facebookIsValid: (->
    if @get('twitter')
      !@_containsSpaces @get('twitter')
    else
      true
  ).property('facebook')

  youTubeIsValid: (->
    if @get('youtube')
      !@_containsSpaces @get('youtube')
    else
      true
  ).property('youtube')

  save: ->
    @get('store').commit() if !@get('errors.length')

  _containsSpaces: (str) ->
    if str
      if str.match(/\s+/) then true else false
    else
      false