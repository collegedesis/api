# CollegeDesis.Router = Ember.Router.extend()

# CollegeDesis.Router.map (match) ->
#   match('/').to('home')
#   match('/calendar').to('calendar')
#   match('/store').to('store')
#   match('/takeAction').to('takeAction')
#   match("/bulletins").to "bulletins"
#     # match("/").to "bulletinIndex"
#   match("/bulletins/new").to "newBulletin"
#   match('/bulletins/:bulletin_slug').to "bulletin"
#   match('/logIn').to "logIn"

# CollegeDesis.HomeRoute = Ember.Route.extend
#   name: 'home'

# CollegeDesis.BulletinsRoute = Ember.Route.extend
#   model: -> CollegeDesis.Bulletin.find()
#   events: 
#     goToBulletin: (bulletin) ->
#       @transitionTo('bulletin', bulletin)

# CollegeDesis.LogInRoute = Ember.Route.extend
#   renderTemplate: (controller, model) ->
#     @render 'logIn',
#       controller: 'session'

# CollegeDesis.NewBulletinRoute = Ember.Route.extend
#   model:  ->
#     CollegeDesis.Bulletin.createRecord()

#   renderTemplate: (controller, model) ->
#     if @controllerFor('application').get('loggedIn')
#       @_super()
#     else
#       @transitionTo('logIn')

#   exit: ->
#     newBulletin = @controllerFor("newBulletin")
#     if !newBulletin.get("id")
#       newBulletin.get('content').deleteRecord() if newBulletin.get('content')


# CollegeDesis.BulletinRoute = Ember.Route.extend

#   serialize: (model, params) ->
#     object = {}
#     name = params[0]
#     object[name] = Em.String.dasherize model.get('title')
#     return object

#   deserialize: (params) ->
#     slug = params['bulletin_slug']
#     title = slug.split('-').join(' ')
#     bulletins = CollegeDesis.Bulletin.find({title: title})
    
#     bulletins.one "didLoad", ->
#       bulletins.resolve(bulletins.get("firstObject"))

#     @currentModel = bulletins

# # CollegeDesis.BulletinsRoute = Ember.Route.extend
# #   model: ->
# #     CollegeDesis.Bulletin.find()
#   # root: Ember.Route.extend
#   #   goToBulletins: Ember.Route.transitionTo('bulletins.index')
#   #   goToCalendar: Ember.Route.transitionTo('calendar')
#   #   goToHome: Ember.Route.transitionTo('home')
#   #   goToTakeAction: Ember.Route.transitionTo('takeAction')
#   #   goToStore: Ember.K
    
#   #   home: Ember.Route.extend
#   #     route: '/'
#   #     enter: (router) ->
#   #       router.get('applicationController').disconnectOutlet('content')

#   #   takeAction: Ember.Route.extend
#   #     route: 'takeaction'
#   #     connectOutlets: (router) ->
#   #       router.get('applicationController').connectOutlet
#   #         name: 'takeAction'
#   #         outletName: 'content'

#   #   bulletins: Ember.Route.extend
#   #     route: 'bulletins'
#   #     goToWriteBulletin: Ember.Route.transitionTo('write')
#   #     goToBulletin: Ember.Route.transitionTo('show')
#   #     show: Ember.Route.extend
#   #       route: '/:bulletin_id'
#   #       connectOutlets: (router, bulletin) ->
#   #         router.get('applicationController').connectOutlet
#   #           name: 'bulletin'
#   #           context: bulletin
#   #           outletName: 'content'
#   #     index: Ember.Route.extend
#   #       route: '/'
#   #       connectOutlets: (router) ->
#   #         router.get('applicationController').connectOutlet
#   #           name: 'bulletins'
#   #           context: CollegeDesis.Bulletin.find()
#   #           outletName: 'content'
#   #     write: Ember.Route.extend
#   #       route: 'new'
#   #       connectOutlets: (router) ->
#   #         router.get('applicationController').connectOutlet
#   #           name: 'newBulletin'
#   #           context: CollegeDesis.Bulletin.createRecord()
#   #           outletName:'content'
#   #       exit: (router) ->
#   #         if router.get('newBulletinController.content.id') is undefined
#   #           router.get('newBulletinController.content').deleteRecord()

#   #   calendar: Ember.Route.extend
#   #     route: 'calendar'
#   #     enter: (router) ->
#   #       router.get('applicationController').disconnectOutlet('content')


#     # goHome: Ember.Route.transitionTo('index.orgs')
#     # selectOne: Ember.Route.transitionTo('index.selected')
#     # goToAddNewOrganization: Ember.Route.transitionTo('index.newOrg')
#     # goToWriteEmail: Ember.Route.transitionTo('index.message')

#     # index: Ember.Route.extend
#     #   route: '/'
#     #   connectOutlets: (router) ->
#     #     orgs = Ember.ArrayProxy.create
#     #       content: CollegeDesis.Organization.find()
#     #     router.get('applicationController').connectOutlet
#     #       name: 'organizations'
#     #       outletName: 'main'
#     #       context: CollegeDesis.Organization.find()

#     #   orgs: Ember.Route.extend
#     #     route: '/'
#     #     connectOutlets: (router) ->
#     #       router.get('applicationController').connectOutlet
#     #         viewClass: CollegeDesis.DescriptionView
#     #         controller: router.get('organizationsController')
#     #         outletName: 'show'

#     #   selected: Ember.Route.extend
#     #     route: '/:organization_id'
#     #     connectOutlets: (router, organization) ->
#     #       router.get('applicationController').connectOutlet
#     #         name:'organization'
#     #         outletName: 'show'
#     #         context: organization

#     #   message: Ember.Route.extend
#     #     route: '/contact'
#     #     connectOutlets: (router) ->
#     #       router.get('applicationController').connectOutlet
#     #         name: 'message'
#     #         outletName: 'show'
#     #         context: CollegeDesis.Message.createRecord()

#     #   newOrg: Ember.Route.extend
#     #     route: '/new'
#     #     connectOutlets: (router) ->
#     #       router.get('applicationController').connectOutlet
#     #         name: 'newOrganization'
#     #         outletName: 'workspace'
#     #         context: CollegeDesis.Organization.createRecord()