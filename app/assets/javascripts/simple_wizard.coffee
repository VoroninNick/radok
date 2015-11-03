window.project ?= {}

window.assets ?= {}
window.assets.test_case_files ?= []

assign_model_key = (model, val)->
  model_keys = model.split(".")
  last_key = model_keys[model_keys.length - 1]
  target = window
  for key, index in model_keys
    if index == model_keys.length - 1
      break
    target[key] ?= {}
    target = target[key]
  target[last_key] = val

window.input_types = {
  "string" : {
    dom_value : (input)->
      $(input).find("input").val()
  }

  "url" : {
    dom_value : (input)->
      $(input).find("input").val()
  }

  "text" : {
    dom_value : (input)->
      $(input).find("textarea").val()
  }

  "radio-button" : {
    dom_value : (input)->
      type = $(input).attr("as")
      model = $(input).attr("model")
      value = $(".input.#{type}[model='#{model}'] input:checked").val()
      value
  }

  "image-radio-button" : {
    dom_value : (input)->
      window.input_types['radio-button'].dom_value(input)
  }

}



window.wizard_form = {
  set_model_value : (value)->
    window.project = value

  jquery_form : $("form[for]")
  url : $("form[for]").attr("url")
  create_method : ()->
    'post'

  update_method : ()->
    'put'

  create_url : ()->
    @url

  update_url : ()->
    self = wizard_form
    if self.url[@url.length - 1] == '/'
      @url + @model.id
    else
      @url + "/" + @model.id

  model : project
  is_persisted : ()->
    !!@model.id
  push : ()->
    self = wizard_form
    data = project
    $("form[for]").trigger("before_push")
    res = do_push = true
    if res

      if self.is_persisted()
        url = @update_url()
        method = @update_method()
        action = 'update'
      else
        url = @create_url()
        method = @create_method()
        action = 'create'



      ajax_options = {
        url: url
        type: method
        data: data
        dataType: 'json'
        success: (response_data)->
          console.log("success", arguments)
          #self.trigger("after_push")
          self.jquery_form.trigger("after_push")

          self.set_model_value(response_data)
          self.jquery_form.trigger("after_#{action}")
      }
      console.log "opts", ajax_options
      $.ajax(
        ajax_options
      )
}

$("body").on "change", ".wizard .input.image-radio-button, .wizard .input.radio-button", ()->
  $input = $(this)
  model = $input.attr("model")
  if $input.hasClass("image-radio-button")
    html_class = "image-radio-button"
  else
    html_class = "radio-button"
  $(".input.#{html_class}[model='#{model}']").removeClass("checked").addClass("unchecked")

  $input.addClass("checked").removeClass("unchecked")

$("body").on "change", ".input[model]", ()->
  $input = $(this)
  model = $input.attr("model")

  input_type = $input.attr("as")
  value = input_types[input_type].dom_value($input)
  assign_model_key(model, value)

  $input.trigger("change.#{model}")



#$("body").on "change", ".wizard .input.radio-button", ()->



$("body").on "click", ".rf-configure-button", ()->
  $("#wizard-controller").addClass("configure-mode")
  hide_unavailable_steps()
  hide_unavailable_platforms()
  show_full_summary()



$("body").on "change", ".project_test_type", ()->
  if is_configure_mode()
    hide_unavailable_steps()

$("body").on "change", ".project_product_type", ->
  hide_unavailable_platforms()


show_full_summary = ()->
  $("#wizard-full-summary").removeClass("hide")

is_configure_mode = ()->
  $("#wizard-controller").hasClass("configure-mode")



hide_unavailable_platforms = ()->
  $platforms_input = $("[as=platforms]")
  #console.log "length", $platforms_input.length
  checked_value = $("[model*=product_type].checked").map(
    (index, item)->
      return $(item).attr("value")
  )[0]

  #console.log "checked_value", checked_value
  platforms_by_product_type_name = JSON.parse($platforms_input.attr("platforms-by-product-type"))
  platform_ids = platforms_by_product_type_name[checked_value]


  $platforms = $(".input[as=platforms] .platform")
  $platforms.addClass("hide")
  for platform_id in platform_ids
    $platform = $platforms.filter("[data-id=#{platform_id}]")
    $platform.removeClass("hide")

  $platforms.filter(":not(.hide)").each(
    (index)->
      $p = $(this)
      #console.log "#{index + 1} : #{((index + 1) % 2 == 0)? 'odd' : 'even'}"
      if (index + 1) % 2 == 0
        $p.addClass("even").removeClass("odd")
      else
        $p.addClass("odd").removeClass("even")
  )

get_test_type_name = ()->
  $("[model*=test_type].checked").attr("value").toLowerCase()

hide_unavailable_steps = ()->
  $step = $(".project-components-step")
  test_type_name = get_test_type_name()
  $next_step = $step.next()
  if test_type_name == 'functional' || test_type_name == 'localization'
    $step.removeClass("hide")
    $next_step.find(".wizard-step-counter").attr("data-number", 4)
  else
    $step.addClass("hide")
    $next_step.find(".wizard-step-counter").attr("data-number", 3)

$("body").on "click", ".option-count .decrement, .option-count .increment", ->
  $btn = $(this)
  increment = $btn.hasClass("increment")
  decrement = !increment
  $input_wrap = $btn.closest(".input-wrap")
  $option_count = $input_wrap.closest(".option-count")
  $input = $input_wrap.find("input")
  $input.focus()
  step = 1
  value = parseInt($input.val()) || 0
  if increment
    new_value = value + step
  else
    new_value = value - step
  if new_value < 0
    new_value = 0



  if value != new_value
    $input.trigger_val(new_value)

    $input.trigger("dom_change")


$("body").on "change", ".input.string, .input.text", ()->
  $input = $(this)
  if $input.hasClass("string")
    val = $input.find("input").val()
  else
    val = $input.find("textarea").val()


  if is_present(val)
    $input.addClass("not-empty").removeClass("empty")
  else
    $input.addClass("empty").removeClass("not-empty")



$("body").on "focusin focusout", ".input", (e)->
  if e.type == 'focusin'
    $(this).addClass("focus")
  else
    $(this).removeClass("focus")

init_string_inputs = ()->
  $(".input.string").each ->
    $input = $(this)
    val = $input.find("input").val()
    if is_present(val)
      $input.addClass("not-empty")
    else
      $input.removeClass("not-empty")

init_tags_input = ()->
  $('.input[model="project.tags"] input').tagsInput({
    defaultText: ""
    onChange: ()->
      $input = $(this).closest(".input")
      $input.trigger("change")
  })



$(document).on "ready", ->
  init_string_inputs()






# step 3

$(document).on "ready", ()->
  show_or_hide_exploratory_instructions_input()

  init_tags_input()


# step 4
$(document).on "ready", ()->
  show_or_hide_auth_credentials_inputs()

$("body").on "change.project.authentication_required", ()->
  show_or_hide_auth_credentials_inputs()


$("body").on "change.project.methodology_type", ()->
  show_or_hide_exploratory_instructions_input()

show_or_hide_exploratory_instructions_input = ()->
  testing_type = $(".input[model*='project.methodology_type'] input:checked").val()
  $input = $(".project_exploratory_instructions_input")

  $file_input = $(".test-case-files-input")

  if testing_type == 'exploratory'
    $input.removeClass("hide")
    $file_input.addClass("hide")
  else
    $input.addClass("hide")
    $file_input.removeClass("hide")

show_or_hide_auth_credentials_inputs = ()->
  requires_auth = $("[model*='project.authentication_required'] input:checked").val() == 'true'
  $input = $(".project_exploratory_instructions_input")

  $credentials_inputs = $(".project-auth-login, .project-auth-password")

  if requires_auth
    $credentials_inputs.removeClass("hide")
  else
    $credentials_inputs.addClass("hide")







$("body").on "change", "input.file-upload-input", ->
  input = this
  $input = $(input)
  $upload_area = $input.closest(".upload-area")

  list_selector = $input.attr("list-selector")
  $list = $(list_selector)
  attachment_name = $input.attr("data-attachment-name")




  new_files_length = input.files.length
  new_files_saved_count = 0
  for file in input.files

    $list.append("<div class='file' data-file-name='#{file.name}'>#{file.name}<span class='delete'></span></div>")
    f = {name: file.name}
    reader = new FileReader()
    reader.onload = ->
#console.log "reader.load", arguments
      src = reader.result
      f.content = src
      assets.test_case_files.push(f)
      new_files_saved_count = new_files_saved_count + 1

      if new_files_length == new_files_saved_count
        $input.val(null)

    reader.readAsDataURL(file);

  $input.simpleUpload("#{wizard_root_path}/#{project.id}/#{attachment_name}", {
    success: (data)->
      file_name = data.data_file_name
      $file = $list.find(".file:not(.loaded)").filter("[data-file-name='#{file_name}']")
      $file.attr("data-id", data.id)
  })



$("body").on "click", ".file-upload-files-list .delete", ->
  $file = $(this).closest('.file')
  file_index = $file.index()
  asset_id = $file.attr("data-id")
  $file.remove()
  assets.test_case_files.splice(file_index, 1)
  $list = $(".file-upload-files-list")
  attachment_name = $list.attr("data-attachment-name")
  $.ajax({
    url: "#{wizard_root_path}/#{wizard.id}/#{attachment_name}/#{asset_id}"
    type: "delete"
    dataType: "json"

  })



$("body").on "click", ".rf-test-case-files-upload-button", (e)->
  $input = $("input#test_case_files")
  $input.click()

$("body").on "click", ".rf-wizard-test-files-upload-button", (e)->
  e.stopImmediatePropagation()
  e.preventDefault()
  $input = $("input#test_files")
  $input.click()
