# extends: Formify.HasFields, Formify.HasGroups, EventedClass

class Formify.Form extends virtual_class EventedClass, Formify.HasGroups
  constructor : ($form, options)->
    #console.log "form.consructor", $form
    super
    #@model = {}
    @jquery_form = $form
    @bind_event_handlers()
    @url = @jquery_form.attr("url")
    @method = @jquery_form.attr("method") || 'post'
    @auto_push_timeout = 2000

  is_persisted : ()->
    !!@model().id

  model : ()->
    window[@jquery_form.attr('for')]



  create_url : ()->
    @url

  update_url : ()->
    if @url[@url.length - 1] == '/'
      @url + @model().id
    else
      @url + "/" + @model().id

  create_method : ()->
    'post'

  update_method : ()->
    'put'



  bind_event_handlers : ()->
    self = this
    @jquery_form.on "submit", ()->
      @push()
    @jquery_form.on "change keyup", ".input", ()->
      $input = $(this)
      $input.trigger("dom_change")

    @jquery_form.on "dom_change", ".input", ()->
      console.log "dom_change"
      $input = $(this)
      input = $input.data().input
      input.assign_model_value_by_dom_value()
      input.handle_changes()
      #self.push()
      if self.push_timeout
        clearTimeout(self.push_timeout)
      self.push_timeout = setTimeout(
        ()->
          self.push.apply(self)
        self.auto_push_timeout)


    @bind "model_change", (model_key)->
      console.log "model_key: ", model_key

  get_model_value : (model_key)->
    model = model_key
    model_keys = model.split(".").slice(1)
    last_key = model_keys[model_keys.length - 1]
    target = @model()
    for key, index in model_keys
      if index == model_keys.length - 1
        break
      target[key] ?= {}
      target = target[key]
    target[last_key]


  set_model_value : (val)->
    window[@jquery_form.attr('for')] = val


#model_value : ()->

  render : ()->
    #inputs = @inputs
    #for input in inputs
    #  input.insert()

    for group in @groups
      group.render()



  is_valid_model_value : ()->

  is_invalid_model_value : ()->
    !is_valid_model_value()

  commit : ()->




  push : ()->
    self = this
    res = @trigger("before_push")
    if res
      data = self.unpushed_changes()

      if @is_persisted()
        url = @update_url()
        method = @update_method()
        action = 'update'
      else
        url = @create_url()
        method = @create_method()
        action = 'create'



      ajax_options = {
        url: url
        type: method
        data: data
        dataType: 'json'
        success: (response_data)->
          console.log("success", arguments)
          self.trigger("after_push")
          self.set_model_value(response_data)
          self.trigger("after_#{action}")
      }
      console.log "opts", ajax_options
      $.ajax(
        ajax_options
      )

  pull : ()->

  unpushed_changes : ()->
    @model()

