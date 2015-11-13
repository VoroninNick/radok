module ApplicationHelper
  def self.self_embedded_svg_from_absolute_path(filename, options = {}, html_safe = true)
    file = File.read(filename.to_s)
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    if options[:class].present?
      svg['class'] = options[:class]
    end
    res = doc.to_html
    res = res.html_safe if html_safe

    res
  end

  def host_name
    Rails.application.config.action_mailer.default_url_options[:host]
  end

  def skype_login
    "force.10g"
  end

  def twitter_login
    "10g_force"
  end

  def google_plus_id
    "109753715460055186428"
  end

  def facebook_login
    "10g.force"
  end

  def linked_in_url
    "https://www.linkedin.com/grp/home?gid=8415315"
  end

  def rf_button(**options)

    options[:html] ||= {}
    options[:svg] ||= false
    options[:title] ||= false
    options[:subtitle] ||= false
    options[:svg_size] ||= :medium
    options[:id] ||= false


    options[:class] = button_class(options)


    options[:button_class] = options.delete(:class)
    options[:disabled] ||= false
    render "helpers/application/rf_button", options
  end

  def button_class(options)
    custom_class = options[:class] || ''
    c = "rf-button "
    if options[:subtitle].present?
      c += " rf-button-with-subtitle"
    else
      c += " rf-button-without-subtitle"
    end
    if options[:svg].present?
      c += " rf-button-with-svg"
    else
      c += " rf-button-without-svg"
    end
    if options[:class].present?
      c += " #{options[:class]}"
    end
    raised = if options[:raised] == false then false else true end
    if raised
      c += " rf-button-raised"
    else
      c += " rf-button-unraised"
    end
    full_width = options[:full_width].present?
    #console.log "full_width: ", full_width
    if full_width
      c += " rf-button-full-width"
    else
      c += " rf-button-auto-width"
    end
    svg_size = options[:svg_size]
    c += " rf-button-svg-size-#{svg_size}"
    align_content = options[:align_content] || "center"
    c += " rf-button-align-content-#{align_content}"

    button_size = options[:size]
    if button_size.blank?
      button_size = 'medium'
    end
    c += " rf-button-size-#{button_size}"


    c += " #{custom_class}"

    c
  end

  def header_user_class
    if respond_to?(:current_user) && current_user
      c = "logged-in"

    else
      c = "unlogged"
    end

    c += " no-avatar"

    return c
  end

  def top_nav(**options)
    options[:dropdowns] ||= []
    options[:menu] ||= []
    options[:item_class] ||= ""
    render "helpers/application/top_nav", options
  end

  def rf_input(**options)
    options[:type] ||= :string
    form_prefix = options.delete :form_prefix
    value = options.delete :value
    tag_name = :input
    type = options.delete(:type)
    tag_name = :textarea if type.to_sym == :text
    input_tag_options = options
    #input_tag_options[:name] ||= form_prefix
    input_tag_options[:class] ||= ""
    input_tag_options[:class] = "#{input_tag_options[:class]}"
    input_type = :text
    input_type = :password if type.to_s == 'password'
    input_tag_options[:type] = "#{input_type}"
    options[:required_message] ||= "#{options[:label]} is required"
    required_message = options[:required_message]
    invalid_message = options[:invalid_message]
    validation = options[:validation]
    taken_message = options[:taken_message]
    model = options[:model]


    input_tag_content = nil
    input_tag_content = value if tag_name == :textarea
    input_tag_options[:value] = value if tag_name == :input
    input_tag_options[:autocomplete] = "off" if options[:autocomplete] == false

    empty = value.blank?

    string_input = type.to_s.in?(%w(string email url password tags))
    text_input = type.to_s.in?(%w(text))

    content_tag(:div, class: "rf-input #{'string' if string_input} #{'text' if text_input} #{'empty' if empty} #{'not-empty' if !empty}", model: (model if model.present?), type: type, "n-inputs-height": (options[:number_inputs_height]), required: ('required' if options[:required]), validation: (validation if validation.present?) ) do
      content_tag(:label, taken_message, class: "hide error taken") +
      content_tag(:label, required_message, class: "hide error required") +
      content_tag(:label, invalid_message, class: "hide error invalid") +
      content_tag(:label, class: "hide error unconfirmed") do content_tag(:span, "Please confirm your email") + link_to("resend instructions", "#", class: "resend_me_instructions") end +
      content_tag(:label, options[:label], class: "field-label") +
      content_tag(:div, nil, class: "input-border-wrap") +

      content_tag(tag_name, input_tag_content, input_tag_options)
    end
  end

  def steps_progress(total_steps_count, completed_step = 0)
    (content_tag("steps-progress") do
      raw([
      content_tag(:label, "Steps completed:"),
      content_tag(:div, class: "progress") do
        raw(total_steps_count.times.map do |i|
          content_tag(:div, class: "step #{'proceeded' if i < completed_step }", style: "width: #{100 / total_steps_count}%;") do
            content_tag :div, nil, class: "inner"
          end
        end.join)
      end
      ].join)
    end)
  end

  def form_errors
    content_tag :div, class: "form-errors hide" do
      content_tag :div, class: "columns large-12" do
        raw(%w(unconfirmed invalid_password_or_login invalid_username_or_email).map do |error_key|
          content_tag :p, class: "form-error semibold #{error_key} hide" do
            raw(t("form-errors.#{error_key}"))
          end
        end.join)
      end
    end
  end

  def popup name, **options
    options[:id] ||= "#{name.gsub(/\//, '__').underscore}_popup"
    options[:visible] ||= false
    render "helpers/application/popup", partial: name, options: options
  end

  def option_image(name, id, value, label, image_path, columns_count = 4)
    render "helpers/wizard/option_image", { name: name, value: value, label: label, image_path: image_path, options: options }
  end


  def wizard_checkbox_list **options
    options[:question] ||= false
    options[:options] ||= []

    options[:required] ||= false

    content_tag :div, class: "rf-input checkbox-list", required: ('' if options[:required]) do
      raw(

        content_tag(:div, class: "question") do
          content_tag(:div, options[:question], class: "text") +
          content_tag(:div, class: "options horizontal") do
            raw(options[:options].each_with_index.map do |opt, i|
              is_default = !options[:default].nil? && opt == options[:default]
              checked = is_default
              id =   "#{options[:field]}-#{i + 1}"
              content_tag(:div, class: "checklist-option") do
                content_tag(:input, nil, id: id, type: "checkbox", value: opt, name: options[:name], checked: (checked) ) +
                content_tag(:label, nil, class: "checklist-option-label", for: id) +
                content_tag(:label, opt, for: id, class: "checklist-option-label")
              end
            end.join)
          end
        end
      )
    end
  end

end
