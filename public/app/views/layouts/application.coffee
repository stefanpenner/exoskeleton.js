class App.AppView extends Backbone.View
  el: $("todoapp")
  statsTemplate: _.template '''
  <% if (total) { %>
    <span class="todo-count">
      <span class="number">
        <%= remaining %>
      </span>
    <span class="word">
      <%= remaining == 1 ? "item" : "items" %>
    </span>left.</span><% } %>
    <% if (done) { %>
      <span class="todo-clear">
        <a href="#">
          Clear 
          <span class="number-done">
            <%= done %>
          </span>
          completed
          <span class="word-done">
            <%= done == 1 ? "item" : "items" %>
          </span>
        </a>
      </span>
    <% } %>
  '''

  events:
    "keypress #new-todo" : "createOnEnter"
    "keyup #new-todo"    : "showTooltip"
    "click .todo-clear"  : "clearCompleted"

  initialize: ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
  
    this.input = this.$("#new-todo")
    
    Todos.bind('add',     this.addOne)
    Todos.bind('refresh', this.addAll)
    Todos.bind('all',     this.render)
  
    Todos.fetch()
  
  render: ->
    done = Todos.done().length

    this.$("#todo-stats").set("html", this.statsTemplate
      done:       done
      total:      Todos.length
      remaining:  Todos.length - done)
  
  addOne: (todo) ->
    view = new TodoView( model: todo ).render().el
    this.$("#todo-list").grab view
    sortableTodos.addItems view
  
  addAll: ->
    Todos.each this.addOne

  createOnEnter: (e) ->
    return if e.code isnt 13

    Todos.create
      content: this.input.getProperty("value")
      done:    false

    this.input.setProperty("value", "")

  showTooltip: (e) ->
    tooltip = this.$(".ui-tooltip-top")
    tooltip.fade("out")
  
    clearTimeout(this.tooltipTimeout) if this.tooltipTimeout
    
    if this.input.getProperty("value") isnt "" and this.input.getProperty("value") isnt this.input.getProperty("placeholder")
      this.tooltipTimeout = setTimeout (-> tooltip.fadeIn("in")), 1000
  
  clearCompleted: ->
    _.each Todos.done(), (todo) -> todo.clear()
    return false
