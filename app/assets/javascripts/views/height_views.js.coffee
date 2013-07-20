App.HeightView = Ember.View.extend
  didInsertElement: ->
    bodyHeight    = $('body').height()
    windowHeight  = $(window).height()
    docHeight     = Math.max(bodyHeight, windowHeight)
    headerHeight  = $('.app-header').height()
    footerHeight  = $('.footer').height()

    height = docHeight - headerHeight - footerHeight
    asideHeight = $('aside').height()
    $('.app-content').css('min-height', (asideHeight + headerHeight))

App.IndexView = App.HeightView.extend()
App.RadioView = App.HeightView.extend()
App.AboutView = App.HeightView.extend()
App.NShowView = App.HeightView.extend()
App.NNewView = App.HeightView.extend()
App.UsersShowView = App.HeightView.extend()
App.NView = App.HeightView.extend()
App.DShowView = App.HeightView.extend()
App.DSettingsView = App.HeightView.extend()
App.LoginView = App.HeightView.extend()