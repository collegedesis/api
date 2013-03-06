CollegeDesis.Bulletin = DS.Model.extend
  title: DS.attr('string')
  body: DS.attr('string')
  created_at: DS.attr('date')

  preview: (->
    return "#{@get('body').slice(0, 20)}..."
  ).property('body')

  slug: (->
    Em.String.dasherize @get('title')
  ).property('title')

  humanizedCreatedAt: (->
    strftime(@get('created_at'),"%b %d, %Y at %I:%M%p") if @get('created_at')?
  ).property("created_at")