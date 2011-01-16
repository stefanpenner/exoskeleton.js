window.App ?= {}

jQuery -> 
  App.controllers =
    helloController: new App.HelloController

  Backbone.history.start()

  $.getJSON 'exoskeleton.json', (data)->
    App.exoskeleton = data
