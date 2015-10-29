class Formify.Inputs.RadioButton extends Formify.Inputs.Base
  constructor : ()->
    super
    self = this
    #@form.jquery_form.on "change", ".input[class*=radio-button]", ()->
    @jquery_input.on "change", ()->
      checked = self.jquery_input.find("input:checked").length > 0
      if checked
        self.jquery_input.addClass("checked")
      else
        self.jquery_input.addClass("unchecked")



  checked : ()->
    if @is_built()
      return @jquery_input.filter(":checked").length > 0
    !!@jquery_input.attr("checked")

  dom_value : ()->
    val = @jquery_input.attr("value")
    type = @jquery_input.attr("type") || 'string'
    if type == 'boolean'
      val = Formify.TypeConverter.parse_boolean(val)

    val

  to_assign_from_dom : ()->
    super && @checked()


  html_id_for : ()->
    id = super
    if id
      val = @value_for()
      id = "#{id}_#{val}"


  html_name_for : ()->
    super + "[]"

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
    checked_string = "checked=''" if @checked()

    "
      <input value='#{value}' type='radio' name='#{input_name}' id='#{input_id}' #{checked_string} />
      <label class='custom-radio-button' for='#{input_id}'></label>
      <label for='#{input_id}' class='label'>#{label}</label>
    "


Formify.Inputs.register("RadioButton")