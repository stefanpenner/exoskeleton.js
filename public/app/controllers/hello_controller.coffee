class App.HelloController extends Backbone.Controller
  routes:
    "help":                 "help"
    "search/:query":        "search"
    "search/:query/p:page": "search"

  help: ->
    console.log "help"

  search: (query, page) -> console.log query,page
