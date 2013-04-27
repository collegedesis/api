App.BulletinsIndexView = Ember.ListView.extend
  height: 600
  width: 665
  elementWidth: 665
  rowHeight: 45
  itemViewClass: Ember.ListItemView.extend({templateName: "bulletins/index_row"})