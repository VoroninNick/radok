module WizardHelper
  def image_radio_button(form, field_name, collection)
    render "components/image_radio_button", {object: object, field_name: field_name}
  end
end