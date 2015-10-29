class Formify.HasFields
  constructor: ()->

    @inputs = []
    @load_fields()

  load_fields : ()->
    self = this
    inputs = @inputs
    $(".input").each (index)->
      $input = $(this)
      presenter = $input.attr("as") || "string"
      #console.log "inputs: ", Formify.Inputs['String']
      input_class_name = presenter.classify()
      presenter_class = Formify.Inputs[input_class_name]
      if presenter_class
        input = new presenter_class($input, index, self)

        inputs.push(input)
        #input.insert()
      else
        console.warn("input #{input_class_name} undefined")

  field_by_model_key : (key)->
    @inputs.filter(
      (field, index)->
        return field.model_key() == key
    )[0] || null