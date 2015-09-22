$header_user = $("#header-user")
window.logged_in = $("html").data().loggedIn == true
$header_user_dropdown = $header_user.find(".dropdown")
$header_user_dropdown.addClass("hide")
$header_user_icon_logged = $(".user-icon.logged")
$header_user_icon_logged.addClass("hide") if !logged_in
$("#body").on "click", ".user-icon.logged", ->
  $("#header-user .dropdown").toggleClass("hide")

$("body").on "click", ".logout-link", (event)->
  event.preventDefault()
  url = $(this).attr("href")
  $.ajax(
    url: url
    type: "delete"
    success: ->
      window.location.reload()
  )

$("body").on "clickout", ".logout-link", ->


$(".menu").on "click", ".has-dropdown", ->
  $this = $(this)
  $this.toggleClass("opened")

openPopup = (popup_name)->
  $popup = $("[id=#{popup_name}_popup]")
  $popup.removeClass("hide")
  if !$popup.hasClass("initialized")
    $popup.addClass("initialized")
    $popup.find("input[type=password]").capsChecker()

$("[disable-click-on-active]").on "click", ".active", (event)->
  $this = $(this)
  event.preventDefault()

$("#header-menu").on "click", "[id=header-user].unlogged", ->
  openPopup("user_pages__static_sign_in")

$("body").on "click", ".ngdialog-overlay, .ngdialog-close", ->
  $ng_dialog = $(this).closest(".ngdialog")
  $ng_dialog.addClass("hide")

$("body").on "click", "[open-popup]", (event)->
  event.preventDefault()
  $this = $(this)
  $current_popup = $(this).closest(".ngdialog")
  $current_popup.addClass("hide")
  $current_popup.find(".ngdialog-overlay").addClass("hide")
  popup_name = $this.attr("open-popup")
  openPopup(popup_name)




$.fn.valid = ->
  return true


$("body").on "submit", "form", (event)->
  event.preventDefault()
  $form = $(this)

  $form.validateForm()
  valid_form = $form.find(".rf-input.invalid").length == 0
  if valid_form
    $form_errors = $(".form-errors")
    form_data = $form.serializeArray()
    url = $form.attr("action")
    method = $form.attr("method") || 'GET'
    $form_content = $form.find(".form-content")
    show_preloader = $form.attr("show-preloader") != undefined
    hide = true
    hide_class = "invisible"
    form_resource_name = $form.attr("resource")
    if show_preloader
      if $form_content.length > 0
        if hide
          $form_content.addClass(hide_class)

      else
        $form.addClass(hide_class)
      $preloader = $form.parent().find(".preloader")
      $preloader.removeClass("hide")
      $("[hide-during-send='']").addClass("hide")



    $.ajax(
      data: form_data
      url: url
      dataType: "json"
      type: method
      success: ->
        #alert("success")
        show_success = $form.attr("show-success") != undefined
        close_on_success = $form.attr("close-on-success")
        reload_on_success = $form.attr("reload-on-success")
        $preloader.addClass("hide") if !reload_on_success
        if show_success
          $success = $form.parent().find(".success-handler")
          $success.removeClass("hide")


        if close_on_success && !reload_on_success
          $form.closest(".ngdialog").addClass("hide")

        if reload_on_success
          window.location.reload()


      error: (xhr)->
        response_json = xhr.responseJSON
        resource_data = response_json[form_resource_name]
        errors_by_field = resource_data.errors if resource_data
        errors_by_field ?= response_json.errors

        if response_json.error == true
          $form_errors.removeClass("hide")
          if response_json.confirmed == false
            $form_errors.find(".unconfirmed").removeClass("hide")
          else
            $form_errors.find(".unconfirmed").addClass("hide")
        else
          $form_errors.addClass("hide")

        form_errors = []
        form_errors = resource_data.form_errors if resource_data
        if !isEmpty(form_errors)
          $form_errors.removeClass("hide")
          for error_key in form_errors
            $(".form-errors .#{error_key}").removeClass("hide")
        else
          $form_errors.addClass("hide")



        console.log "errors", errors_by_field

        $form.find(".inputs .error").addClass("hide")

        if !isEmpty(errors_by_field)
          for field_name, errors of errors_by_field
            console.log "error field_name", field_name
            console.log "error errors", errors
            $field = $form.find("[name='#{form_resource_name}[#{field_name}]']").closest(".rf-input")
            console.log "form_resource_name: ", form_resource_name
            console.log "field_name: ", field_name
            $field.addClass("invalid")
            error_key = errors
            error_key = errors[0] if Array.isArray(errors)
            console.log "error_key", error_key
            window.$FIELD = $field
            $error = $field.find(".error.#{error_key}")
            $error.removeClass("hide")



        #alert("error")
        if $form_content.length > 0
          $form_content.removeClass(hide_class)
        else
          $form.removeClass(hide_class)
        $preloader.addClass("hide")
        $("[hide-during-send='']").removeClass("hide")
        console.log "args: ", arguments
    )

#$("body").on "focus keypress", "input[type=password]", (event)->
#  console.log "event: ", event

$("body").on "capson", ->
  $(".caps-lock-warning").removeClass("hide")
$("body").on "capsoff", ->
  $(".caps-lock-warning").addClass("hide")


$("body").on "focusin focusout", ".rf-input input", (event)->
  $input = $(this)
  $rf_input = $input.closest(".rf-input")
  focus = event.type == 'focusin'
  if focus
    $rf_input.addClass("focus-in")
  else
    $rf_input.removeClass("focus-in")

$("body").on "change", ".rf-input input", (event)->
  $input = $(this)
  $rf_input = $input.closest(".rf-input")
  empty = $input.val().length == 0

  if empty
    $rf_input.addClass("empty").removeClass("not-empty")
  else
    $rf_input.addClass("not-empty").removeClass("empty")


$("body").on "click", ".resend_me_instructions", (event)->
  event.preventDefault()
  $resend_instruction_button = $(this)
  $please_wait = $("<span>Wait please...</span>")
  $login = $resend_instruction_button.closest("form").find("input[name='user[login]']")
  login = $login.val()
  $resend_instruction_button.replaceWith($please_wait)
  data = { user: { login: login } }
  $.ajax(
    data: data
    url: "/users/confirmation"
    type: "post"
    dataType: "json"
    success: (data)->
      $please_wait.replaceWith("<span>Instructions successfully sent</span>")
  )

$("body").on "click", ".rf-button", (event)->
  $button = $(this)
  href = $button.attr("href")
  if href && href.length
    window.location = href

$.fn.validateInput = ->
  $rf_input = $(this)
  required = !!$rf_input.attr("required")
  $input = $rf_input.find("input")
  value = $input.val()
  valid = true
  $field_label = $rf_input.find(".field-label")

  $form = $rf_input.closest("form")
  if required
    valid = value && value.length
  if valid
    $rf_input.find(".error.required").addClass("hide")
  else
    $rf_input.find(".error.required").removeClass("hide")




  validation_options_str = $rf_input.attr("validation") || ""
  validation_options = validation_options_str.split(" ")

  if valid
    if validation_options.indexOf("email") >= 0
      valid = validateEmail(value)
      if valid
        $rf_input.find(".error.invalid").addClass("hide")
      else
        $rf_input.find(".error.invalid").removeClass("hide")

  if !valid
    $rf_input.addClass("invalid").removeClass("valid")
    $field_label.removeClass("hide")

  else
    $rf_input.removeClass("invalid").addClass("valid")
    $field_label.addClass("hide")

  if !valid
    $form.addClass("invalid").removeClass("valid")



$.fn.validateForm = ->
  $form = $(this)
  $form.find(".rf-input").each ->
    $rf_input = $(this)
    $rf_input.validateInput()
  $form

validateEmail = (email) ->
  re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i
  re.test email


$("body").on "change blur", "form .rf-input input", (event)->

  console.log "event type: ", event.type
  console.log "value: ", $(this).val()
  $input = $(this)
  $rf_input = $input.closest(".rf-input")
  if event.type == 'change'
    $rf_input.find(".error.taken").addClass("hide")

  $rf_input.validateInput()

