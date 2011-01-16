class App.TodoView extends Backbone.View
  tagName: "li"
  className: "todo"

  template: _.template "
  <input type='checkbox' class='todo-check' />
  <div class='todo-content'></div>
  <span class='todo-destroy'></span>
  <input type='text' class='todo-input' />"

  events:
    "click .todo-check"      : "toggleDone"
    "dblclick .todo-content" : "edit"
    "click .todo-destroy"    : "clear"
    "keypress .todo-input"   : "updateOnEnter"
    
  initialize: ->
    _.bindAll this, 'render', 'close'
    this.model.bind 'change', this.render
    this.model.view = this
  
  render: ->
    $(this.el).set('html', this.template(this.model.toJSON()))
    $(this.el).setProperty("id", "todo-"+this.model.id)
    this.setContent()
    sortableTodos.addItems(this.el)
    return this
  
  setContent: ->      
    content = this.model.get('content')
    this.$('.todo-content').set("html", content)
    this.$('.todo-input').setProperty("value", content)
    
    if this.model.get('done')
      this.$(".todo-check").setProperty("checked", "checked")
      $(this.el).addClass("done")

    else
      this.$(".todo-check").removeProperty("checked")
      $(this.el).removeClass("done")
    
    this.input = this.$(".todo-input")
    this.input.addEvent('blur', this.close)
  
  toggleDone: ->
    this.model.toggle()
  
  edit: ->
    $(this.el).addClass("editing")
    this.input.fireEvent("focus")
    this.input.focus()
  
  close: ->
    this.model.save
      content: this.input.getProperty("value")

    $(this.el).removeClass("editing")
  
  updateOnEnter: (e) ->
    if e.code == 13
      this.close()
  
  clear: ->
    this.model.clear()
