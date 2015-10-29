class Formify.Inputs.Base extends EventedClass
  constructor : ($input, form_input_index, parent)->
    @parent = parent
    @jquery_input = $input
    #console.log "$input", $input
    @html_node = @jquery_input.get(0)

    @jquery_input.data("form_input_index", form_input_index)
    @jquery_input.data("input", this)


    @assign_model_value_by_dom_value()
    @handle_changes()






  form : ()->
    @parent.parent

  is_built : ()->
    @jquery_input && @jquery_input.length > 0 && @jquery_input.children().length > 0

  model_key : ()->
    @jquery_input.attr("model")



  has_model_key : ()->
    parts = @model_key().split(".")
    root = window
    model = root
    for p, i in parts
      if !model.hasOwnProperty(p)
        return false
      model = model[p]

  assign_model_key1 : (val)->
    parts = @model_key().split(".")
    root = window
    model = root
    for p, i in parts
      if i < parts.length - 1
        model[p] ?= {}
        model = model[p]
      else
        model[p] ?= val

  assign_model_key : (val)->
    model = @model_key()
    model_keys = model.split(".")
    last_key = model_keys[model_keys.length - 1]
    target = window
    for key, index in model_keys
      if index == model_keys.length - 1
        break
      target[key] ?= {}
      target = target[key]
    target[last_key] = val

  handle_changes : ()->

  assign_model_value_by_dom_value : ()->
    val = @dom_value()

    if typeof val == 'undefined'
      val = null

    @assign_model_key(@model_value)



    if @form()
      @form().trigger("model_change", @model_key())

    #console.log "assign_model_value_by_dom_value", @model_value

  render : ()->
    console.error("NotImplementedException")

  dom_value : ()->
    #console.warn("NotImplementedWarning")
    if @is_built()
      @jquery_input.val()
    else
      @jquery_input.attr("value")



  label_for : ()->

    label = @jquery_input.attr('label')
    if label && label.length
      return label
    translation_key = "labels." + @jquery_input.attr("model")
    t(translation_key)


  placeholder_for : ()->
    translation_key = "placeholders." + @jquery_input.attr("model")
    t(translation_key)






  value_for : ()->
    @jquery_input.attr("value")

  html_id_for : ()->
    html_id = null
    model = @jquery_input.attr("model")
    if model && model.length

      html_id = model.replace(/\./g, "_")



      return html_id
    else
      return null

  html_name_for : ()->
    html_id = null
    model = @jquery_input.attr("model")
    if model && model.length
      html_id = model.replace(/\./g, "_")

    else
      return null

  insert : ()->
    str = @render()
    @html_node.innerHTML = str


  check_for_presense : (val)->
    is_present(val)

  is_valid : ()->
    val = @model_value
    if @jquery_input.hasAttribute("required")
      check_for_presense(val)

