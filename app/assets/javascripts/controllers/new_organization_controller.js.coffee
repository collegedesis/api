# CollegeDesis.NewOrganizationController = Ember.ObjectController.extend
#   selectedType: null

#   createNew:(e) ->
#     newOrg = e.context.get('content')
#     CollegeDesis.router.get('store').commit()

#   org_types: (->
#     org_types = CollegeDesis.router.store.find(CollegeDesis.OrganizationType)
#     return org_types
#   ).property()