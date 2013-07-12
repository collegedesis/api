App.ListView = Ember.ListView.extend
  height: 500,
  rowHeight: 50,
  width: 346,
  itemViewClass: Ember.ListItemView.extend({templateName: "bulletins/_index_row"})

  didInsertElement: ->
    asideHeight = $('aside').height()
    @set('height', asideHeight)
    @_super()