class Formify.Inputs.Text extends Formify.Inputs.Base

  dom_value : ()->
    @jquery_input.find("textarea").val() || ""

  render : ()->
    input_id = @html_id_for()
    input_name = @html_name_for()
    $input_field = null

    value = @value_for()

    stringified_value = value
    stringified_value = "" if stringified_value == null || stringified_value == undefined


    placeholder = @placeholder_for()
    label = @label_for()
    label_string = ""
    if label
      label_string = "<label for='#{input_id}' class='label'>#{label}</label>"

    "
      #{label_string}
      <label for='#{input_id}' class='placeholder'>#{placeholder}</label>
      <textarea id='#{input_id}' class='input-tag' type='text' name='#{input_name}' />

    "


Formify.Inputs.register("Text")