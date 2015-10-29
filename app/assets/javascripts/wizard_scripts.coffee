class window.WizardForm extends Formify.Form
  constructor : ()->
    super
    self = this

    #@bind "before_push",
    @bind "after_create", ()->

      window.history.pushState({}, "", "#{wizard_root_path}/#{self.model().id}")


window.project = new Project

window.form = new WizardForm($("form[for]"))
form.render()