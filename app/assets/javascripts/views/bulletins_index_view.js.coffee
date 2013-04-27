App.BulletinsIndexView = Ember.ListView.extend
  height: 500
  width: 665
  elementWidth: 665
  rowHeight: 40
  itemViewClass: Ember.ListItemView.extend({templateName: "bulletins/index_row"})