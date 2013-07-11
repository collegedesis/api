App.HeightView = Ember.View.extend
  didInsertElement: ->
    bodyHeight    = $('body').height()
    windowHeight  = $(window).height()
    docHeight     = Math.max(bodyHeight, windowHeight)
    headerHeight  = $('.app-header').height()
    footerHeight  = $('.footer').height()

    height = docHeight - headerHeight - footerHeight

    # $('.app-content').css('min-height', height)

App.IndexView = App.HeightView.extend()
App.RadioView = App.HeightView.extend()
App.AboutView = App.HeightView.extend()
App.BulletinsShowView = App.HeightView.extend()
App.BulletinsNewView = App.HeightView.extend()
App.UsersShowView = App.HeightView.extend()
App.NewsView = App.HeightView.extend()
App.OrganizationsShowView = App.HeightView.extend()
App.OrganizationsSettingsView = App.HeightView.extend()
App.LoginView = App.HeightView.extend()