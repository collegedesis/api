# PASSWORD = "br0wnt3st3r0511"

# CollegeDesis.MessageController = Ember.ObjectController.extend

#   unlockPassword: null
#   confirmCode: null
#   testSent: false
#   verificationEmailHasBeenSent: false
#   verifyPassword: null

#   sending: false
  
#   inWriteMode: true

#   recipients: (->
#     CollegeDesis.router.get('organizationsController.selectedOrgs')
#   ).property('CollegeDesis.router.organizationsController.selectedOrgs.@each')

#   toggleMode: ->
#     @set('inWriteMode', !@get('inWriteMode'))

#   verifySender: ->
#     @set('sending', true)
#     $.ajax
#       type: "POST"
#       url: "/verifications/verify?sender=#{@get('from_email')}"
#       success: (data) =>
#         @set('verificationEmailHasBeenSent', true)
#         @set 'confirmCode', data.code
#         @set('sending', false)

#   emailHasBeenVerified: (->
#     if @get('verificationEmailHasBeenSent')
#       pass = @get('verifyPassword') || ""
#       return true if @get("confirmCode") == MD5(pass)
#     else
#       return false
#   ).property('confirmCode', 'verifyPassword')

#   sendMessage: ->
#     @set('content.to_str', @get('recipients').mapProperty('id').join(','))
#     @_save()
#     @_reset()
#     CollegeDesis.router.send('goHome')
  
#   sendTest: ->
#     transaction = @get('store').transaction()
#     transaction.createRecord CollegeDesis.TestEmail,
#       from_email: @get('from_email')
#       from_name: @get('from_name')
#       body: @get('body')
#       subject: @get('subject')
#     transaction.commit()
#     @set('testSent', true)

#   _save: ->
#     @get('store').commit()
  
#   # View Specific computed properties that should probably go in view
#   unlocked: (->
#     if @get('unlockPassword') == PASSWORD then true else false
#   ).property('unlockPassword')

#   readyToSend: (-> if @get('validEmail') then true else false ).property('validEmail')

#   selected_with_emails: (->
#     @get("recipients").filterProperty('has_email', true)
#   ).property('recipients.@each.has_email')

#   _reset: ->
#     @set('unlockPassword', null)
#     @set('confirmCode', null)
#     @set('testSent', false)
#     @set('verificationEmailHasBeenSent', false)
#     @set('verifyPassword', null)
#     @set('sending', false)

#   validEmail: (->
#     val = false # invalid email by default
#     valid_email_format = new RegExp('(.+)@(.+)\.(com|org|edu|net)', 'ig')
#     val = true if valid_email_format.test(@get('from_email'))
#     return val
#   ).property('from_email')