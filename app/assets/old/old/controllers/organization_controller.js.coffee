# CollegeDesis.OrganizationController = Ember.ObjectController.extend
#   first_name: null
#   last_name: null
#   email: null
#   password: null # entered by the user
#   confirmCode: null # to check against
#   currentTransaction: null
#   currentUser: null

#   # Booleans that dictate the state of the form
#   sending: false
#   verificationSent: false
#   formVisible: false

#   emailHasBeenVerified: (->
#     if @get('verificationSent')
#       pass = @get('password') || ""
#       return true if @get("confirmCode") == MD5(pass)
#     else
#       return false
#   ).property('confirmCode', 'password')

#   verifyEmail: ->
#     @set('sending', true)
#     $.ajax
#       type: "POST"
#       url: "/verifications/verify?sender=#{@get('email')}"
#       success: (data) =>
#         @set('verificationSent', true)
#         @set 'confirmCode', data.code
#         @set('sending', false)

#   createUser: ->
#     user = @get('currentTransaction').createRecord CollegeDesis.User,
#       first_name: @get('first_name')
#       last_name: @get('last_name')
#       email: @get('email')
#     @get('currentTransaction').commit()
#     @set('currentUser', user)

#     if user.get('isNew')
#       user.addObserver('id', this, 'createMembership');

#   createMembership: ->
#     organization = @get('content')
#     user = @get("currentUser")
#     newMembership = @get('content.memberships').createRecord()
#     newMembership.set('organization', organization)
#     newMembership.set('user', user)

#     @get('store').commit()
#     @_resetForm()

#   showForm: ->
#     @set 'currentTransaction', @get('store').transaction()
#     @set('formVisible', true)

#   _resetForm: ->
#     @set('verificationSent', false)
#     @set('password', null)
#     @set('confirmCode', null)
#     @set('currentUser', null)
#     @set('currentTransaction', null)
#     @set('formVisible', false)
#     @set('first_name', null)
#     @set('last_name', null)
#     @set('email', null)