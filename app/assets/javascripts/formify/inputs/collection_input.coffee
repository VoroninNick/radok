class Formify.Inputs.CollectionInput extends Formify.Inputs.Base
  constructor : ()->
    super
    options = JSON.parse(@jquery_input.attr("options"))

    @options = options

#  options : ()->
#    @_options || []

