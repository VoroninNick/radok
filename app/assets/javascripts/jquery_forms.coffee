window.Formify = {}
Formify.Inputs = {
  registered_input_types: []
  register: (name)->
    @registered_input_types.push(name)
  all: ()->
    @registered_input_types
}

class Formify.Inputs.Base
  constructor : ($input, form_input_index, form)->
    @form_instance = form
    @model_value = null
    @jquery_input = $input
    @html_node = @jquery_input.get(0)
    @jquery_input.data("form_input_index", form_input_index)
  assign_model_value_by_dom_value : ()->


  render : ()->
    console.error("NotImplementedException")

  dom_value : ()->
    @jquery_input.val()
  label_for : ()->

    label = @jquery_input.attr('label')
    if label && label.length
      return label
    translation_key = "labels." + @jquery_input.attr("model")
    t(translation_key)


  placeholder_for : ()->
    translation_key = "placeholders." + @jquery_input.attr("model")
    t(translation_key)

  input_type : ()->
    type = "string"
    type = "text" if @jquery_input.hasClass("text")
    type = "collection-check-boxes" if @jquery_input.hasClass("collection-check-boxes")
    type = "boolean" if @jquery_input.hasClass("boolean")

    type
  presenter_for : ()->
    as = @jquery_input.attr("as")
    if !as
      type = @input_type()
      if "string text collection-check-boxes".split(' ').indexOf(type) >= 0
        as = type
      else if type == 'boolean'
        as = 'radio-button'


    as

  value_for : ()->
    @jquery_input.attr("value")

  html_id_for : ()->
    html_id = null
    model = @jquery_input.attr("model")
    if model && model.length

      html_id = model.replace(/\./g, "_")
      if "radio-button".split(' ').indexOf(@presenter_for()) >= 0
        value = @value_for()
        html_id += "_#{value}"


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




class Formify.Inputs.String extends Formify.Inputs.Base

  dom_value : ()->
    @jquery_input.find("input").val()

  render : ()->
    input_id = @html_id_for()
    input_name = @html_name_for()
    $input_field = null

    value = @value_for()

    stringified_value = value
    stringified_value = "" if stringified_value == null || stringified_value == undefined


    placeholder = @placeholder_for()
    label = @label_for()

    "
      <label for='#{input_id}' class='label'>#{label}</label>
      <label for='#{input_id}' class='placeholder'>#{placeholder}</label>
      <input class='input-tag' type='text' name='#{input_name}' />

    "

class Formify.Inputs.Text extends Formify.Inputs.Base

  dom_value : ()->
    @jquery_input.find("input").val()

  render : ()->
    input_id = @html_id_for()
    input_name = @html_name_for()
    $input_field = null

    value = @value_for()

    stringified_value = value
    stringified_value = "" if stringified_value == null || stringified_value == undefined


    placeholder = @placeholder_for()
    label = @label_for()

    "
      <label for='#{input_id}' class='label'>#{label}</label>
      <label for='#{input_id}' class='placeholder'>#{placeholder}</label>
      <textarea class='input-tag' type='text' name='#{input_name}' />

    "

class Formify.Inputs.RadioButton extends Formify.Inputs.Base

  checked : ()->
    @jquery_input.attr("checked")

  dom_value : ()->
    @jquery_input.find("input").val()

  render : ()->
    input_id = @html_id_for()
    input_name = @html_name_for()
    $input_field = null

    value = @value_for()

    stringified_value = value
    stringified_value = "" if stringified_value == null || stringified_value == undefined


    placeholder = @placeholder_for()
    label = @label_for()

    checked_string = ''
    checked_string = "checked=''" if @checked

    "
      <label for='#{input_id}' class='label'>#{label}</label>
      <input type='radio' name='#{input_name}' id='#{input_id}' #{checked_string} />
      <label class='custom-radio-button' for='#{input_id}'></label>

    "


class Formify.Inputs.CollectionInput extends Formify.Inputs.Base
  constructor : ()->
    super(arguments)
    options = JSON.parse(@jquery_input.attr("options"))

    @_options = options

  options : ()->
    @_options || []

class Formify.Inputs.CollectionCheckBoxes extends Formify.Inputs.CollectionInput
  render : ()->
    input_id = @html_id_for()

    options_string = ""
    for option in @options
      option_html_id = input_id + "_" + option.id
      option_text = option.name || ""
      options_string += "<span class='option'><input type='checkbox' id='#{option_html_id}' /> <label class='custom-checkbox' for='#{option_html_id}'></label> <label for='#{option_html_id}'>#{option_text}</label> </span>"
    "
    <label for='#{input_id}' class='label'>#{label}</label>
    <div class='options'>
    #{options_string}
    </div>
    "


class Formify.Inputs.Platforms extends Formify.Inputs.CollectionInput
  render : ()->
    input_id = @html_id_for()

    options_string = ""

    platforms_collection_string = ""

    for p in @options

      platform_options_collection_string = ""

      if p.children && p.children.length
        for child_platform in p.children
          platform_option_string = "
            <div class='option-count'>
              <div class='platform-option-label'>#{child_platform.name}</div>
              <div class='input-wrap'>
                <input value='0' pattern='[0-9]*' type='text'>
                <label class='decrement' for='platform-1-subitem-1'>
                <label class='increment' for='platform-1-subitem-1'>
              </div>
            </div>
            "

          platform_options_collection_string += platform_option_string


      platform_options_string = "
        <div class='platform-options'>
          #{platform_options_collection_string}
        </div>
      "

      platform_string = "
        <div class='platform'>
          <div class='name platform-label'>#{p.name}</div>
          <div class='human-svg-wrap platform-user-icon'>#{window.svg_images.user}</div>
          #{platform_options_string}
        </div>
        "

      platforms_collection_string += platform_string

      input_html = "
        <div>
        #{platforms_collection_string}
        </div>
      "

Formify.Inputs.register("String")
Formify.Inputs.register("Text")
Formify.Inputs.register("RadioButton")
Formify.Inputs.register("CollectionCheckBoxes")


class Formify.Form
  constructor : ($form)->
    @inputs = []
    @model = {}
    @jquery_form = $form
    @bind_event_handlers()

  bind_event_handlers : ()->
    @jquery_form.on "submit", ()->
      @push()
    @jquery_form.on "change keyup", ".input", ()->
      $input = $(this)
      $input.trigger("dom_change")
    @jquery_form.on "dom_change", ".input", ()->
      $input = $(this)
      $input.write_model_value()
  model_value : ()->

  render : ()->
    inputs = @inputs
    $(".input").each (index)->
      $input = $(this)
      presenter = "String"
      input = new Formify.Inputs[presenter]($input, index)
      inputs.push(input)
      input.render()



  is_valid_model_value : ()->

  is_invalid_model_value : ()->
    !is_valid_model_value()

  commit : ()->

  push : ()->

  pull : ()->





$.fn.formify = ()->
  $form = $(this)
  window.form = new Formify.Form($form)
  form.render()



#$("#new_wizard_test").formify()