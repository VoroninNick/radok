class Formify.Inputs.String extends Formify.Inputs.Base
  constructor : ()->
    super
    @bind "after_change", ()->
      console.log "String.after_change : 1"

  dom_value : ()->
#console.log "String::dom_value"
    if @is_built()
      @jquery_input.find("input").val()
    else
      @jquery_input.attr("value")

  handle_changes : ()->
    if is_present(@dom_value())
      @jquery_input.addClass("not-empty")
    else
      @jquery_input.addClass("empty")



  render : ()->
    input_id = @html_id_for()
    input_name = @html_name_for()
    $input_field = null

    value = @model_value()

    stringified_value = value
    stringified_value = "" if stringified_value == null || stringified_value == undefined


    placeholder = @placeholder_for()
    label = @label_for()



    "
      <label for='#{input_id}' class='label'>#{label}</label>
      <label for='#{input_id}' class='placeholder'>#{placeholder}</label>
      <input id='#{input_id}' value='#{stringified_value}' class='input-tag' type='text' name='#{input_name}' />

    "


Formify.Inputs.register("String")