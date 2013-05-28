App.RotatingView = Ember.ContainerView.extend
  currentTemplate: ""
  tagName: 'span'
  # available templates are set when the view is instantiated
  templates: Em.A()

  init: ->
    @_super()
    # start the updating templates setInterval method
    # and assign a handle to it.
    func = @updateTemplates()
    @set('intervalFunc', func)

  # Clear the interval method
  willDestroyElement: ->
    clearInterval @get('intervalFunc')

  # when the currentTemplate changes
  # build a new currentView object
  currentView: (->
    App.RotatingViewTemplate.create
      template: Ember.Handlebars.compile @get('currentTemplate')
  ).property('currentTemplate')

  # setInterval function that is called on init
  updateTemplates: ->
    return setInterval (=>
      @set 'currentTemplate', @_updateCurrentTemplate()
    ), 2000

  # change the currentTemplate
  _updateCurrentTemplate: ->
    templates     = @get('templates')
    numOfViews    = templates.length
    currentIndex  = templates.indexOf @get('currentTemplate')
    newIndex = if (currentIndex + 1) == numOfViews then 0 else currentIndex + 1
    return templates[newIndex]

App.RotatingViewTemplate = Ember.View.extend
  tagName: 'span'
  classNames: ['heading animated fadeInUp ']

  willDestroyElement: ->
    @$().removeClass('fadeInUp')
    @$().addClass('fadeOutUp')