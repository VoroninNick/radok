module WizardHelper
  def next_step_button(step_number, step_name)
    render "helpers/wizard/next_step_button", { step_number: step_number, step_name: step_name }
  end

  def go_button(text = "Next", ng = {})
    ng = Hash[ng.map {|k, v| ["ng-#{k}", v] }]
    render "helpers/wizard/go_button", { text: text, ng: ng }
  end

  def next_question_button ng = {}
    ng = Hash[ng.map {|k, v| ["ng-#{k}", v] }]
    render "helpers/wizard/next_question_button", { ng: ng }
  end

  def summary_button
    render "helpers/wizard/summary_button", {  }
  end

  def configure_button ng = {}
    # rename_keys for ng attributes
    ng = Hash[ng.map {|k, v| ["ng-#{k}", v] }]
    render "helpers/wizard/configure_button", { ng: ng }
  end

  def prev_step_button(prev_step_number)
    render "helpers/wizard/prev_step_button", { prev_step_number: prev_step_number }
  end

  def intro_step(step_number = nil, step_title = nil, html_class = false, &block)
    render "helpers/wizard/wizard_step", { step_number: nil, step_title: step_title, html_class: html_class, block: block }, &block
  end

  def wizard_step(step_number, step_title = nil, html_class = false, &block)

    render "helpers/wizard/wizard_step", { step_number: step_number, step_title: step_title, html_class: html_class, block: block }, &block

  end

  def option_image(image_path, name, label, value, ng_model, columns_count = 4, description = nil)
    render "helpers/wizard/option_image", { image_path: image_path, name: name, label: label, value: value, ng_model: ng_model, description: description, columns_count: columns_count }
  end

  def blue_header(text, columns = false)
    render "helpers/wizard/blue_header", { text: text, columns: columns }
  end

  def platform(name, image_path = nil, ng = {}, commentable = true, &block)
    ng = Hash[ng.map {|k, v| ["ng-#{k}", v] }]
    render "helpers/wizard/platform", { name: name, image_path: image_path, ng: ng, commentable: commentable, block: block }, &block
  end

  def option_count(name, ng_model, count = 0)
    render "helpers/wizard/option_count", { name: name, count: count, ng_model: ng_model }
  end

  def radio_input(name, label, value, checked = false, description = nil, &block)
    render "helpers/wizard/radio_input", { name: name, label: label, value: value, description: description, checked: checked, block: block }, &block
  end

  def checkbox_input(name, label, value, checked = false)
    render "helpers/wizard/checkbox_input", { name: name, label: label, value: value, checked: checked }
  end

  def question(text, ng = {}, centered = false , &block)
    ng = Hash[ng.map {|k, v| ["ng-#{k}", v] }]
    render "helpers/wizard/question", { text: text, centered: centered, ng: ng, block: block }, &block
  end

  def svg_placeholder(image_path)
    render "helpers/wizard/svg_placeholder", { image_path: image_path }
  end
end
