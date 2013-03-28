App.Bulletin = DS.Model.extend
  title: DS.attr('string')
  body: DS.attr('string')
  url: DS.attr('string')
  bulletin_type: DS.attr('number')
  created_at: DS.attr('date')
  errors: []

  votes: DS.hasMany('App.Vote')

  preview: (->
    if @get('body')
      "#{@get('body').slice(0, 20)}..."
  ).property('body')

  slug: (->
    Em.String.dasherize @get('title')
  ).property('title')

  humanizedCreatedAt: (->
    strftime(@get('created_at'),"%b %d, %Y at %I:%M%p") if @get('created_at')?
  ).property("created_at")

  htmlBody: (->
    converter = new Showdown.converter({ extensions: ['video'] })
    new Ember.Handlebars.SafeString converter.makeHtml(@get('body')) if @get('body')
  ).property('body')

  isPost: (-> @get('bulletin_type') == 1 ).property('bulletin_type')
  isLink: (-> @get('bulletin_type') == 2 ).property('bulletin_type')