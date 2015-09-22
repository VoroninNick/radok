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

  def rf_button(**options)


    options[:svg] ||= false
    options[:title] ||= false
    options[:subtitle] ||= false
    options[:svg_size] ||= :medium
    options[:id] ||= false

    options[:class] = button_class(options)


    options[:button_class] = options.delete(:class)
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
    tag_name = :input
    type = options.delete(:type)
    tag_name = :textarea if type.to_sym == :text
    input_tag_options = options
    #input_tag_options[:name] ||= form_prefix
    input_tag_options[:class] ||= ""
    input_tag_options[:class] = "#{input_tag_options[:class]}"
    input_type = :text
    input_type = :password if type.to_s == 'password'
    input_tag_options[:type] = input_type
    content_tag(:div, class: "rf-input", type: type, "n-inputs-height": (options[:number_inputs_height])) do
      content_tag(:label, "Please confirm your email", class: "hide error unconfirmed") +
      content_tag(:label, options[:label], class: "field-label") +
      content_tag(:div, nil, class: "input-border-wrap") +
      content_tag(tag_name, nil, input_tag_options)
    end.html_safe
  end

  def popup name, **options
    options[:id] ||= "#{name.gsub(/\//, '__').underscore}_popup"
    render "helpers/application/popup", partial: name, options: options
  end


end
