module WizardHelper
  def image_radio_button(form, field_name, collection)
    render "components/image_radio_button", {object: object, field_name: field_name}
  end

  def slim name, context = nil

    source = WizardText.first.try{|t| break nil if !t.respond_to?(name); t.send(name)}
    if source.blank?
      yield

      return nil
    else
      context ||= self
      tpl = Slim::Template.new() { source }
      if context
        tpl.render(context)
      else
        tpl.render
      end
    end
  end
end