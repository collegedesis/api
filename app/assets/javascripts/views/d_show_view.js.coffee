App.OrganizationDisplayView = Ember.ContainerView.extend

  currentView: (->
    if @get('controller.isEditing') then @get('editView') else @get('readView')
  ).property('controller.isEditing')

  readView: Ember.View.create({templateName: 'd/show_read'})
  editView: Ember.View.create({templateName: 'd/show_edit'})