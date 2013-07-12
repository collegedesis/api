App.ListView = Ember.ListView.extend
  height: 500,
  rowHeight: 50,
  width: 342,
  itemViewClass: Ember.ListItemView.extend({templateName: "bulletins/_index_row"})

  didInsertElement: ->
    asideHeight = $('aside').height()
    footerHeight = parseInt($('.footer').css('height'))
    @set('height', (asideHeight - footerHeight))
    @_super()