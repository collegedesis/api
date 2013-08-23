# Vendor libs
#= require md5
#= require showdown
#= require showdown-youtube
#= require ga-analytics
#= require dateFormatter
#= require jquery
#= require jquery_ujs
#= require jquery.mousewheel
#= require raphael
#= require mapsvg

# Ember libs

#= require handlebars
#= require ember
#= require ember-data
#= require list-view

# Ember Application
#= require_self
#= require collegedesis

window.App = Ember.Application.create
  ready: ->
    if location.hash
      window.location = location.origin + location.hash.slice(1)

App.Router.reopen
  location: 'history'