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
App.BulletinsIndexView = App.HeightView.extend()
App.BulletinsShowView = App.HeightView.extend()