$document = $(document)

window.locales = {
  en: {
    labels:
      project:
        project_name: "What is the name of this wonderful project?"
        project_version: "What is version number of the new release that you'd like us to test?"
        project_languages: "In what language(s) is the project?"
        report_languages: "In what language(s) should the bugs be reported?"
        methodology_type: "What methodology are you looking for?"
        components: "What are the product's main components?"
        project_source: "Please provide the URL or file to be tested?"
        authentication_required: "Does the product require a username or password to be accessed?"
    placeholders:
      project:
        project_name: "Project name"
        project_version: "Project version"
        exploratory_description: "Please provide testing instructions for the testers here..."
        auth_login: "Username"
        auth_password: "Password"

  }
}



window.current_locale = "en"

window.t = (key)->
  obj = locales[current_locale]
  keys = key.split('.')
  for k in keys
    if(obj[k])
      obj = obj[k]
    else
      return null

  return obj

$.fn.label_for = ()->
  $input = $(this)
  label = $input.attr('label')
  if label && label.length
    return label
  translation_key = "labels." + $(this).attr("model")
  t(translation_key)

$.fn.placeholder_for = ()->
  translation_key = "placeholders." + $(this).attr("model")
  t(translation_key)

$.fn.input_type = ()->
  $input = $(this).closest(".input")
  type = "string"
  type = "text" if $input.hasClass("text")
  type = "collection-check-boxes" if $input.hasClass("collection-check-boxes")
  type = "boolean" if $input.hasClass("boolean")

  type

$.fn.presenter_for = ()->
  $input = $(this).closest(".input")
  as = $input.attr("as")
  if !as
    type = $input.input_type()
    if "string text collection-check-boxes".split(' ').indexOf(type) >= 0
      as = type
    else if type == 'boolean'
      as = 'radio-button'


  as

$.fn.value_for = ()->
  $input = $(this).closest(".input")

  $input.attr("value")

$.fn.html_id_for = ()->
  html_id = null
  $input = $(this).closest(".input")
  model = $input.attr("model")
  if model && model.length

    html_id = model.replace(/\./g, "_")
    if "radio-button".split(' ').indexOf($input.presenter_for()) >= 0
      value = $input.value_for()
      html_id += "_#{value}"


    return html_id
  else
    return null


$.fn.html_name_for = ()->
  html_id = null
  $input = $(this).closest(".input")
  model = $input.attr("model")
  if model && model.length
    html_id = model.replace(/\./g, "_")

  else
    return null




$("body").on "focus", ".input", ()->


$.init_inputs = ()->
  $(".input:not(.input-initialized)").each ->
    $input = $(this)

    input_id = $input.html_id_for()

    input_name = $input.html_name_for()






    type = $input.input_type()

    $input_field = null

    value = $input.value_for()

    stringified_value = value
    stringified_value = "" if stringified_value == null || stringified_value == undefined

    presenter = $input.presenter_for()


    placeholder = $input.placeholder_for()

    if placeholder && placeholder.length
      $input.prepend("<label for='#{input_id}' class='placeholder'>#{placeholder}</label>")


    label_class = 'label'
    label_class = 'option-label' if 'radio-button'.split(" ").indexOf(presenter) >= 0

    label_after_input = "radio-button checkbox".split(' ').indexOf($input.presenter_for()) >= 0



    label = $input.label_for()
    $label = null
    if label && label.length
      $label = $("<label for='#{input_id}' class='label'>#{label}</label>")
    else
      $input.addClass("without-label")

    if $label && !label_after_input
      $input.prepend($label)



    if presenter.in w('string url')
      $input_field = $("<input type='text' name='#{input_name}' />")
    else if presenter == 'text'
      $input_field = $("<textarea name='#{input_name}'>#{stringified_value}</textarea>")
    else if presenter == 'radio-button'
      checked_string = ''
      checked_string = "checked=''" if $input.attr("checked")
      $("<input type='radio' name='#{input_name}' id='#{input_id}' #{checked_string} /><label class='custom-radio-button' for='#{input_id}'></label> ").appendTo($input)
    else if presenter == 'collection-check-boxes'
      options = JSON.parse($input.attr("options"))
      $options = $("<div class='options'></div>")
      for option in options
        option_html_id = input_id + "_" + option.id
        option_text = option.name || ""
        $options.append("<span class='option'><input type='checkbox' id='#{option_html_id}' /> <label class='custom-checkbox' for='#{option_html_id}'></label> <label for='#{option_html_id}'>#{option_text}</label> </span>")

      $input.append($options)
    else if presenter == 'platforms-input'
      platforms = JSON.parse($input.attr("options"))
      $platforms_input_content = $("<div></div>")
      for p in platforms
        $platform = $("<div class='platform'></div>")
        $platform_header = $("<div class='name platform-label'>#{p.name}</div>")
        $user_icon = $("<div class='human-svg-wrap platform-user-icon'>" + window.svg_images.user + "</div>")
        $platform.append($user_icon)

        $platform_options = $("<div class='platform-options'></div>")
        if p.children && p.children.length
          for child_platform in p.children
            $platform_option = $("<div class='option-count'></div>")
            $platform_option_label = $("<div class='platform-option-label'>#{child_platform.name}</div>")
            $platform_option.append($platform_option_label)

            $platform_option_input_wrap = $("<div class='input-wrap'></div>")
            $platform_option_input_wrap.append("<input value='0' pattern='[0-9]*' type='text'>")
            $platform_option.append($platform_option_input_wrap)
            $platform_option_input_decrement = $("<label class='decrement' for='platform-1-subitem-1'>")
            $platform_option_input_increment = $("<label class='increment' for='platform-1-subitem-1'>")
            $platform_option_input_wrap.append($platform_option_input_decrement)
            $platform_option_input_wrap.append($platform_option_input_increment)

            $platform_options.append($platform_option)


        $platform.append($platform_header)
        $platform.append($platform_options)

        $platforms_input_content.append($platform)
      $platforms_input_content.append("<div class='clearfix'></div>")
      $input.append($platforms_input_content)
    else


    if $input_field
      $input_field.attr('id', input_id)
      $input_field.addClass("input-tag")
      $input_field.appendTo($input)
    if $label && label_after_input
      $input.append($label)

    $input.addClass("input-initialized")

$document.on "ready", ->
  window.current_locale = $("#html").attr("lang") || "en"
  #$.init_inputs()

  #console.log "hi"


