class Formify.HasGroups
  constructor: ()->
    @groups = []
    @load_groups()

  load_groups : ()->
    self = this
    groups = @groups
    $("fieldset").each (index)->
      $group = $(this)
      group = new Formify.Group($group, index, self)
      self.groups.push(group)

      window.groups ?= []
      window.groups.push(group)
