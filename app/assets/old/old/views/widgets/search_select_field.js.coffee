CollegeDesis.SearchSelectField = Ember.TextField.extend
 
  focusOut: -> 
    $('#search_results').css('visibility', 'hidden')

  focusIn: ->
    $('#search_results').css('visibility', 'visible')