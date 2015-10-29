class Formify.Inputs.ImageRadioButton extends Formify.Inputs.RadioButton
  render : ->
    input_id = @html_id_for()
    input_name = @html_name_for()
    $input_field = null

    value = @value_for()

    stringified_value = value
    stringified_value = "" if stringified_value == null || stringified_value == undefined


    placeholder = @placeholder_for()
    label = @label_for() || value

    checked_string = ''
    checked_string = "checked=''" if @checked()

    image_url = @jquery_input.attr("image")

    "
      <input value='#{value}' type='radio' name='#{input_name}' id='#{input_id}' #{checked_string} />
      <label for='#{input_id}' class='image-label'>\
        <img src='#{image_url}' />
      </label>
      <label for='#{input_id}' class='label'>#{label}</label>
    "