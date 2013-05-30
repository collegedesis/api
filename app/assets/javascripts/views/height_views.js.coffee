App.HeightView = Ember.View.extend
  didInsertElement: ->
    docHeight     = $(window).height()
    headerHeight  = $('.app-header').height()
    footerHeight  = $('#footer').height()

    height = docHeight - headerHeight - footerHeight

    $('.app-content').css('min-height', height)

App.IndexView = App.HeightView.extend()
App.RadioView = App.HeightView.extend()
App.AboutView = App.HeightView.extend()
App.BulletinsShowView = App.HeightView.extend()
App.BulletinsNewView = App.HeightView.extend()
App.UsersShowView = App.HeightView.extend()
App.NewsView = App.HeightView.extend()
App.OrganizationsShow = App.HeightView.extend()