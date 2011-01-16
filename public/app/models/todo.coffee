class App.Todo extends Backbone.Model
  toggle: ->
    this.save
      done: !this.get "done"

class App.TodoList extends Backbone.Collection
  model: App.Todo

  #localStorage: new Store("todos")

  done: ->
    this.filter (todo) ->
      todo.get('done')
  
  nextOrder: ->
    return 1 unless this.length

    this.last().get('order')+1

  comparator: (todo) ->
    todo.get('order')

  pluralize: (count) ->
    count == 1 ? 'item' : 'items'

App.Todos = new App.TodoList
