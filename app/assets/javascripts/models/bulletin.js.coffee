App.Bulletin = DS.Model.extend
  title: DS.attr('string')
  body: DS.attr('string')
  url: DS.attr('string')
  bulletin_type: DS.attr('number')
  created_at: DS.attr('date')
  errors: []
  votes: DS.hasMany('App.Vote')
  comments: DS.hasMany('App.Comment')
  user: DS.belongsTo('App.User')
  slug: DS.attr('string')
  author: DS.belongsTo('App.Organization')
  score: DS.attr('number')

  roundedScore: (->
    parseInt @get('score')
  ).property('score')

  preview: (->
    if @get('body')
      "#{@get('body').slice(0, 20)}..."
  ).property('body')

  humanizedCreatedAt: (->
    if @get('created_at')?
      strftime(@get('created_at'),"%B %d, %Y")
    else
      "Date"
  ).property("created_at")

  htmlBody: (->
    converter = new Showdown.converter({ extensions: ['video'] })
    new Ember.Handlebars.SafeString converter.makeHtml(@get('body')) if @get('body')
  ).property('body')

  isPost: (-> @get('bulletin_type') == 1 ).property('bulletin_type')
  isLink: (-> @get('bulletin_type') == 2 ).property('bulletin_type')