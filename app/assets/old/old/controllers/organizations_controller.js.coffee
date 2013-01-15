# DANCE = ['8', '9', '10', '11']
# ACAPPELLA = ['12']
# CULTURAL = ['1', '2', '3', '4']
# RELIGIOUS = ['5', '6', '7']

# CollegeDesis.OrganizationsController = Ember.ArrayController.extend
#   keyword: null
#   orgTypeFilter: null
#   stateFilter: null
#   # http://jsbin.com/edesad/1/edit
#   orgs: (-> @get('content') ).property('content')

#   selectedOrgs: (->
#     @get('searchContent').filterProperty('is_selected', true)
#   ).property('searchContent.@each.is_selected')

#   danceOrgs:      (-> @_filterTypes(DANCE)      ).property('orgs.@each.org_type')
#   aCappellaOrgs:  (-> @_filterTypes(ACAPPELLA) ).property('orgs.@each.org_type')
#   culturalOrgs:   (-> @_filterTypes(CULTURAL)   ).property('orgs.@each.org_type')
#   religiousOrgs:   (-> @_filterTypes(RELIGIOUS)   ).property('orgs.@each.org_type')
  
#   _filterTypes: (type_ids) ->
#     orgs = @get('orgs')
#     orgs.filter (org) ->
#       type_ids.contains org.get('org_type.id')

#   filterDance: ->
#     @set('keyword', "type:dance")
#     @get("danceOrgs").forEach (org) ->
#       org.set('is_selected', true)
    
#   filterACappella: ->
#     @set('keyword', "type:a cappella")
#     @get('aCappellaOrgs').forEach (org) ->
#       org.set('is_selected', true)

#   filterCultural: ->
#     @set('keyword', "type:cultural")
#     @get('culturalOrgs').forEach (org) ->
#       org.set('is_selected', true)    

#   somethingIsSelected: (->
#     true if @get('searchContent').findProperty('is_selected', true)
#   ).property('searchContent.@each.is_selected')

#   selectedAll: false

#   toggleSelectAll: (->
#     if @get('selectedAll')
#       @get('searchContent').forEach (org) =>
#         org.set('is_selected', true)
#     else
#       @get('searchContent').forEach (org) =>
#         org.set('is_selected', false)
#   ).observes('selectedAll')

#   select: (e) ->
#     org = e.context
#     org.set('is_selected', !org.get('is_selected'))
  
#   # Filter by ORG_TYPE
#   filteredByType: (->
#     orgs = @get('content')
#     if @get('orgTypeFilter')
#       orgs = orgs.filterProperty('org_type', @get('orgTypeFilter'))
#       if @get('keyword') == null || @get('keyword') == ""
#         @set('keyword', 'all')
#     return orgs
#   ).property('orgTypeFilter', '@each.org_type')

#   # Filter by STATE
#   filteredByState: (->
#     orgs = @get('filteredByType')
#     if @get('stateFilter')
#       orgs = orgs.filterProperty('state', @get('stateFilter'))
#       if @get('keyword') == null || @get('keyword') == ""
#         @set('keyword', 'all')
#     return orgs
#   ).property('stateFilter', 'filteredByType.@each.state')

#   searchContent: (->
#     keyword = new RegExp(@get('cleanSearchParam'), "ig")
#     orgs = @get('filteredByState')
#     if @_searchBeginsWithAll()
#       arr = orgs
#     else
#       arr = orgs.filter (item) ->
#         item.get('name').match(keyword) if item.get('name')

#     return arr || []
#   ).property('keyword',  'filteredByState.@each.name')

#   _isBlank: (str) ->
#     return (!str || /^\s*$/.test(str))

#   _haskeyword: ->
#     if @get('keyword') then true else false

#   _searchBeginsWithAll: ->
#     if "all" == @get('cleanSearchParam').split(" ").slice(0, 1)[0] then true else false

#   _removeKeyword: (keyword, target) ->
#     target.split(" ").splice("").splice(1, target.length).join(" ")

  
#   org_types: (->
#     CollegeDesis.Organization.all().mapProperty('org_type').uniq()
#   ).property('@each.org_type', 'searchContent')

#   states: (->
#     CollegeDesis.Organization.all().mapProperty('state').uniq().sort()
#   ).property('@each.state', 'searchContent')


#   cleanSearchParam: (->
#     keyword = @get('keyword') || ""
#     keyword = @_removeSpecialCharacters(keyword)
#     keyword.toLowerCase()
#   ).property('keyword')

#   _removeSpecialCharacters: (str) ->
#     str.replace(/[^0-9a-z \-]/ig, '') 


#   # ================== Used in Description View =============== #

#   num_of_states: (-> 
#     @get("content").mapProperty('university.state').uniq().get('length')
#   ).property('content.@each.university.state')

#   num_of_universities: (->
#     @get('content').mapProperty('university.name').uniq().get('length')
#   ).property('content.@each.university.name')
