App.ListView = Ember.ListView.extend
  height: 500,
  rowHeight: 60,
  width: 342,
  itemViewClass: Ember.ListItemView.extend({templateName: "n/_index_row"})

  didInsertElement: ->
    asideHeight = $('aside').height()
    footerHeight = parseInt($('.footer').css('height'))
    @set('height', (asideHeight - footerHeight))
    @_super()