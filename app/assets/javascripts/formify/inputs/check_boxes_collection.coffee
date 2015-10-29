class Formify.Inputs.CollectionCheckBoxes extends Formify.Inputs.CollectionInput

  dom_value : ()->
    if @is_built()
      @jquery_input.find(".option input:checked").map(
        (index, dom_node)->
          $input = $(dom_node)
          $input.attr('value')
      ).toArray()
    else
      val = @jquery_input.attr("value")
      if val
        return val.split(",")
      else
        return []


  render : ()->
    input_id = @html_id_for()
    label = @label_for()
    options_string = ""
    for option, index in @options
      option_html_id = input_id + "_" + (option.id || index + 1)
      option_text = option.name || option || ""
      option_value = option_text
      options_string += "<span class='option'><input type='checkbox' id='#{option_html_id}' value='#{option_value}' /> <label class='custom-checkbox' for='#{option_html_id}'></label> <label for='#{option_html_id}'>#{option_text}</label> </span>"
    "
    <label for='#{input_id}' class='label'>#{label}</label>
    <div class='options'>
    #{options_string}
    </div>
    "


Formify.Inputs.register("CollectionCheckBoxes")