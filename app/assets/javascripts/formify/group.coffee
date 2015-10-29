class Formify.Group extends Formify.HasFields
  constructor : (@jquery_element, index, parent)->
    super

    @parent = parent
    @jquery_element.data("parent_index", index)


  render : ()->
    for input in @inputs
      input.insert()