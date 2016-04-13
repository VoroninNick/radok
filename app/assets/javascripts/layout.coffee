old_model_binding = false
$preloader = null

$("input.autocompleteOff").attr("autocomplete","off");
setTimeout ()->
  $(".rf-input.autocomplete-off[type=password]").each ()->
    $rf_input = $(this)
    $rf_input.find("input").attr("type", "password")
  50

window.wizard_root_path = $("form[for]").attr("url") || $("#dashboard-projects").attr("data-wizard-root")
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

window.openPopup = (popup_name)->
  if typeof popup_name == 'string'
    $popup = $("[id=#{popup_name}_popup]")
  else if popup_name instanceof(jQuery)
    $popup = popup_name
  else
    $popup = null

  if $popup && $popup.length
    $("body").addClass("opened-popup")
    $popup.removeClass("hide")
    if !$popup.hasClass("initialized")
      $popup.addClass("initialized")
      $popup.find("input[type=password]").capsChecker()

$("[disable-click-on-active]").on "click", ".active", (event)->
  $this = $(this)
  event.preventDefault()

$.fn.closeDialog = ()->
  $ng_dialog = $(this).closest(".ngdialog")
  $ng_dialog.addClass("hide")
  if $(".ngdialog").length
    $("body").removeClass("opened-popup")

$("body").on "click", ".ngdialog-overlay, .ngdialog-close", ->
  $ng_dialog = $(this)
  $ng_dialog.closeDialog()

$("body").on "click", "[open-popup]", (event)->
  $this = $(this)
  if $this.attr("disabled") == 'disabled'
    return
  open_popup_from_popup_only = !!$this.attr("open-popup-from-popup-only")
  condition = true
  if open_popup_from_popup_only
    condition = $this.closest(".ngdialog").length > 0
  if condition
    event.preventDefault()
    $current_popup = $(this).closest(".ngdialog")
    $current_popup.addClass("hide")
    popup_name = $this.attr("open-popup")
    if $this.attr("requires-auth") && $("html").attr("data-logged-in") != "true"
      openPopup("user_pages__static_sign_in")
    else
      openPopup(popup_name)

$.fn.valid = ->
  return true

default_form_success_handler = (data, state, options)->
  $form = state.$form
  $preloader = state.$preloader
  $form_content = state.$form_content
  show_success = $form.attr("show-success") != undefined
  close_on_success = $form.attr("close-on-success")
  reload_on_success = $form.attr("reload-on-success")

  $preloader.addClass("hide") if !reload_on_success && $preloader && $preloader.length

  show_success_popup = $form.attr("success-popup")
  if show_success_popup && show_success_popup.length
    $success_popup = $("#" + show_success_popup)
    $success_popup.removeClass("hide")
  if show_success
    $success = $form.parent().find(".success-handler")
    $success.removeClass("hide")
    $form.trigger("show_success", data)
  if close_on_success && !reload_on_success
    $form.closest(".ngdialog").addClass("hide")
  if reload_on_success
    window.location.reload()
  show_on_success = $form.attr("show-on-success") != undefined
  if show_on_success
    $form_content.removeClass(options.hide_class)
    $form.find(".form-message").removeClass("hide")
  $form.trigger("after_success", arguments)

default_form_error_handler = (xhr, state, options)->
  form_resource_name = state.form_resource_name
  $form_errors = state.$form_errors
  $form = state.$form
  $form_content = state.$form_content
  hide_class = options.hide_class
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

  $form_errors.find(".form-error").addClass("hide")
  if !isEmpty(form_errors)
    $form_errors.removeClass("hide")
    for error_key in form_errors
      $form_errors.find(".#{error_key}").removeClass("hide")
  else
    $form_errors.addClass("hide")

  $form.find(".inputs .error").addClass("hide")

  if !isEmpty(errors_by_field)
    for field_name, errors of errors_by_field
      $field = $form.find("[name='#{form_resource_name}[#{field_name}]']").closest(".rf-input")
      $field.addClass("invalid")
      error_key = errors
      error_key = errors[0] if Array.isArray(errors)
      window.$FIELD = $field
      $error = $field.find(".error.#{error_key}")
      $error.removeClass("hide")

  if $form_content.length > 0
    $form_content.removeClass(hide_class)
  else
    $form.removeClass(hide_class)
  $preloader.addClass("hide")
  $("[hide-during-send='']").removeClass("hide")
  $form.trigger("after_error", arguments)

$("body").on "submit", "form:not([no-processing])", (event)->
  event.preventDefault()

  $form = $(this)
  $form.find(".rf-input").addClass("touched")
  type = $form.attr("type")

  if window.form_types && window.form_types[type]
    form_type = window.form_types[type]
  else
    form_type = {}

  if form_type.validateForm
    form_type.validateForm.call($form)
  else
    $form.validateForm()
  valid_form = $form.find(".rf-input.invalid").length == 0
  if valid_form
    $form_errors = $form.find(".form-errors")
    if form_type.serialize
      form_data = form_type.serialize.call($form)
    else
      form_data = $form.serializeArray()
      $(form_data).each ->
        this.value = this.value.trim()

    if form_type.url
      url = form_type.url.apply($form)
    else
      url = $form.attr("action")
    method = $form.attr("ajax-method") || $form.attr("method") || 'GET'
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
    success_handler = form_type.success_handler || default_form_success_handler
    error_handler = form_type.error_handler || default_form_error_handler

    $.ajax(
      data: form_data
      url: url
      dataType: "json"
      type: method
      success: (data)->
        state = {}
        state.$form = $form
        state.$preloader = $preloader
        state.$form_content = $form_content
        options = {}
        success_handler.call(this, data, state, options)
      error: (xhr)->
        state = {}
        options = {}
        state.form_resource_name = form_resource_name
        state.$form_errors = $form_errors
        state.$form = $form
        state.$form_content = $form_content
        options.hide_class = hide_class
        error_handler.call(this, xhr, state, options)
    )

$("body").on "show_success", "form.forgot-password-form", (event, data)->
  $form = $(this)
  $email_placeholder = $form.find(".success-handler .email-placeholder")
  user = data.user
  $email_placeholder.text(user.email)

$("body").on "capson", ->
  $(".caps-lock-warning").removeClass("hide")
$("body").on "capsoff", ->
  $(".caps-lock-warning").addClass("hide")

$("body").on "focusin focusout", ".rf-input input, .rf-input textarea", (event)->
  $input = $(this)
  $rf_input = $input.closest(".rf-input")
  $rf_input.addClass("touched")
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
  $form = $rf_input.closest("form")
  form_try_send = $form.hasClass("try-send")
  touched = $rf_input.hasClass("touched")
  required = !!$rf_input.attr("required")
  value = $rf_input.val().trim()

  if value && value.length
    $rf_input.addClass('not-empty').removeClass("empty")
  else
    $rf_input.addClass('empty').removeClass("not-empty")
  valid = true
  $field_label = $rf_input.find(".field-label")

  if required
    valid = value && value.length

  if valid
    $rf_input.find(".error.required").addClass("hide")
  else
    $rf_input.find(".error.required").removeClass("hide")
    $rf_input.find(".error.invalid").addClass("hide")

  validation_options_str = $rf_input.attr("validation") || ""
  validation_options = validation_options_str.split(" ")

  if valid
    if validation_options.indexOf("email") >= 0
      valid = validateEmail(value)

      if valid
        $rf_input.find(".error.invalid").addClass("hide")
      else
        $rf_input.find(".error.invalid").removeClass("hide")

    if validation_options.indexOf("phone") >= 0
      valid = validatePhoneNumber(value)

      if valid
        $rf_input.find(".error.invalid").addClass("hide")
      else
        $rf_input.find(".error.invalid").removeClass("hide")

  if !valid
    $rf_input.addClass("invalid").removeClass("valid")
    $field_label.addClass("hide")

  else
    $rf_input.removeClass("invalid").addClass("valid")
    $field_label.removeClass("hide")

  if !valid
    $form.addClass("invalid").removeClass("valid")

$.fn.validateForm = (options)->
  $form = $(this)
  $form.find(".rf-input").each ->
    $rf_input = $(this)
    $rf_input.validateInput()
  $form

validateEmail = (email) ->
  re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i
  re.test email

validatePhoneNumber = (number) ->
  re = /^\+(?:[0-9] ?){6,14}[0-9]$/
  re.test number

$("body").on "change blur keyup", "form .rf-input", (event)->
  $rf_input = $(this)
  if event.type == 'change'
    $rf_input.find(".error.taken").addClass("hide")
  $rf_input.validateInput()

$("body").on "click", ".tab-labels > :not(.active)", ->
  $tab_label = $(this)
  $tab_labels = $tab_label.closest(".tab-labels")
  tab_index = $tab_label.index()
  $active_tab_label = $tab_labels.children().filter(".active")
  $active_tab_label.removeClass("active")
  active_tab_index = $active_tab_label.index()
  $tabs = $tab_labels.closest(".tabs")
  $tab_contents = $tabs.find(".tab-contents")
  $active_tab_content = $tab_contents.children().filter(".active")
  $active_tab_content.removeClass("active")
  $tab_content = $tab_contents.children().eq(tab_index)
  $tab_label.addClass("active")
  $tab_content.addClass("active")
  #setContainerSize()

setContainerSize = ()->
  $profile_tab_contents_wrap = $(".profile-tab-contents-row-wrap")
  $profile_tab_contents_wrap.css("min-height", '')
  wrap_height = $("#wrap").height()
  header_height = $("#header").height()
  #profile_header_outer_height = $("#profile-header").outerHeight()
  #$profile_tabs_wrap_height = $(".profile-tab-labels-row-wrap").height()
  main_height = $("main").height()

  difference = wrap_height - (header_height + main_height)
  if difference > 0
    min_height = $profile_tab_contents_wrap.height() + difference
    $profile_tab_contents_wrap.css("min-height", min_height)

$("body").on "click", ".delete-account", ->
  delete_confirmed = confirm("Do you really want delete your account? This action cannot be reverted")
  if delete_confirmed
    $.ajax(
      url: "/users",
      type: "delete"
      dataType: "json"
      complete: ()->
        window.location.reload()
    )

$(window).on "resize", setContainerSize
$(window).trigger("resize")

$("body").on "change", "#subscribe_form__subscribe", ->
  subscribe = $(this).filter(":checked").length > 0
  data = { subscribe: subscribe }
  $.ajax(
    url: "/update_subscription"
    type: "post"
    dataType: "json"
    data: data
    success: ->
  )

$("body").on "change", "#input-file-uploader", ->
  $photo_image_wrap = $(".photo-image-wrap")
  $no_image = $photo_image_wrap.find(".no-image")
  $no_image.addClass("hide")
  input = this
  file = input.files[0]
  imageType = /image.*/
  $image_label = $(".image-label")
  $image_label.removeClass("hide")
  if file.type.match(imageType)
    reader = new FileReader()
    reader.onload = ->
      src = reader.result
      $img = $image_label.find("img")
      $header_user = $("#header-user")
      $header_user.find(".svg-wrap").remove()
      $header_user_icon_inner = $header_user.find(".user-icon .inner")
      $image_wrap = $header_user_icon_inner.find(".image-wrap")
      if $image_wrap.length == 0
        $image_wrap = $("<div class='image-wrap'><img /></div>").appendTo($header_user_icon_inner)
      $header_img = $image_wrap.find("img")
      $header_img.attr("src", src)
      if $img.length == 0
        $img = $("<img />")
        $image_label.append($img)
      $img.attr("src", src)
      data = {user: {avatar: src}  }
      $.ajax(
        url: "/profile"
        type: "post"
        dataType: "json"
        data: data
        headers:
          "Content-Type": "multipart/form-data"
          "X-File-Name": file.name
          "X-File-Size": file.size
          "X-File-Type": file.type
        success: (data)->
          $header_img.attr('src', data.user.avatar.header_image.url)
          $img.attr('src', data.user.avatar.profile_image.url)
      )

    reader.readAsDataURL(file);
  else
    $image_label.text("File type is not supported")

$('body').on 'input propertychange', "#personal-data input", (evt) ->
  $input = $(this)

  # If it's the propertychange event, make sure it's the value that changed.
  if window.event and event.type == 'propertychange' and event.propertyName != 'value'
    return

  # Clear any previously set timer before setting a fresh one
  window.clearTimeout $(this).data('timeout')
  $(this).data 'timeout', setTimeout((->
    # Do your thing here
      $form = $input.closest("form")
      $form.submit()

    ), 2000)

$("body").on "change blur keyup", "div.rf-input input, div.rf-input textarea", (e)->
  $(this).closest("div.rf-input").trigger(e.type, arguments)

$("body").on "change", "div.rf-input.checkbox-list input", ()->
  $checkbox_list = $(this).closest("div.rf-input.checkbox-list")
  $checkbox_list.trigger("change")

$("body").on "click", ".rf-input[type=tags] span.tag a", ()->
  $tag = $(this).closest("span.tag")
  $rf_input = $tag.closest(".rf-input")
  tag_index = $tag.index()
  $tag.remove()
  $rf_input.trigger("change")

if old_model_binding
  $("body").on "keyup change", "[model]", (e)->
    $rf_input = $(this)
    model = $rf_input.attr("model")
    model_keys = model.split(".")
    last_key = model_keys[model_keys.length - 1]
    target = window
    for key, index in model_keys
      if index == model_keys.length - 1
        break
      target[key] ?= {}
      target = target[key]
    target[last_key] = $(this).val()

$.read_models = ()->
  $("[model]").each ->
    $input = $(this)
    model = $input.attr("model")
    model_keys = model.split(".")
    target = window
    for key in model_keys
      target = target[key]

    if $input.filter(".rf-boolean-input").length
      is_true = $(this).val() == true
      if !is_true
        $input.prop("checked", "checked")

$(document).on "ready", ->
  $('.footable').footable({
    parsers: {
      alpha: window.footable.options.parsers.alpha, # default alpha & numeric parsers
      numeric: window.footable.options.parsers.numeric,
      display_size: (cell)->
        return $(cell).text()
    },
    sorters: {
      alpha: window.footable.options.sorters.alpha, # default alpha & numeric sorters
      numeric: window.footable.options.sorters.numeric,
      display_size: (a, b)->
        arr1 = $.trim(a).split("x").map( (a)-> parseInt(a) )
        arr2 = $.trim(b).split("x").map( (a)-> parseInt(a) )

        w1 = arr1[0]
        h1 = arr1[1]

        w2 = arr2[0]
        h2 = arr2[1]

        if w1 > w2
          return 1
        else if w1 == w2
          return h1 - h2
        else
          return -1

        return 1
        # here you are passed two values from the column and you must return a comparison of the two.
        if (a == b)
          return 1
        if (a < b)
          return -1
        return 1;
    }
  })
  #$.read_models()

$("body").on "click", ".return_to_wizard", (e)->
  e.preventDefault()
  $(this).closeDialog()

$("body").on "click", ".schedule-call-button", ->
  openPopup("wizard__schedule_call")

$("body").on "click", "#header-mobile-menu-button-wrap", ()->
  $("body").toggleClass("mobile-menu-opened")

$(".subscribe-block form").on "after_error", (e, xhr, state, options)->
  response = xhr.responseJSON
  c = response.code
  msg = false
  if c && c.length > 0
    if c.indexOf("List_RoleEmailMember: ") == 0
      msg = c.substr("List_RoleEmailMember: ".length)
  subscribed = response.subscribed
  if subscribed
    msg = "This email already subscribed"

  $error = state.$form_content.find(".error")
  if !$error.length
    $error = $("<label class='error'>#{msg}</label>")
    state.$form_content.append($error)
  else
    $error.text(msg)
