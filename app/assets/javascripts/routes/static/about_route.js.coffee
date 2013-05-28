App.AboutIndexRoute = Ember.Route.extend
  redirect: -> @transitionTo('about.intro')

App.AboutIntroRoute = Ember.Route.extend
  activate: -> $(document).attr('title', 'CollegeDesis - About')

App.AboutContactRoute = Ember.Route.extend
  activate: -> $(document).attr('title', 'CollegeDesis - Contact')