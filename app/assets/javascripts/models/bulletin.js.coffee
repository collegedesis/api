CollegeDesis.Bulletin = DS.Model.extend
  title: DS.attr('string')
  body: DS.attr('string')

  preview: (->
    return "#{@get('body').slice(0, 20)}..."
  ).property('body')