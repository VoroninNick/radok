window.Formify = {}

Formify.Inputs = {
  registered_input_types: []
  register: (name)->
    @registered_input_types.push(name)
  all: ()->
    @registered_input_types
}