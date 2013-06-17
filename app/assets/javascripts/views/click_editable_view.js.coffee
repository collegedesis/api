App.ContenteditableView = Em.View.extend
  tagName: "div"
  attributeBindings: ["contenteditable"]

  # Toggle plain text inside the <div> element:
  plaintext: false

  # Variables:
  contenteditable: true
  isUserTyping: false

  # Observers:
  valueObserver: (->
    @setContent() if not @get("isUserTyping") and @get("value")
  ).observes("value")

  # Events:
  didInsertElement: ->
    @setContent()

  focusOut: ->
    @set "isUserTyping", false

  keyDown: (event) ->
    @set "isUserTyping", true  unless event.metaKey

  keyUp: (event) ->
    if @get("plaintext")
      @set "value", @$().text()
    else
      @set "value", @$().html()

  setContent: ->
    @$().html @get("value")