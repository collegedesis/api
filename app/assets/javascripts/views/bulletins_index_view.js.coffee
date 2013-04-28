App.BulletinsIndexView = Ember.ListView.extend
  height: 445
  width: 600
  elementWidth: 600
  rowHeight: 40
  itemViewClass: Ember.ListItemView.extend({templateName: "bulletins/index_row"})