window.project ?= {}

window.$wizard_controller = $("#wizard-controller")

window.price_per_hour = parseInt($wizard_controller.attr("data-hour-price"))

log_input_value = false


window.assets ?= {}
window.assets.test_case_files ?= []

window.small = (size = 640)->
  ratio = window.devicePixelRatio
  ratio ?= 1
  width = window.innerWidth
  if width <= size || width / ratio <= size
    return true
  else
    return false

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

    set_dom_value : (value)->
      $(this).find("input").val(value)
  }

  "url" : {
    dom_value : (input)->
      $(input).find("input").val()

    set_dom_value : (value)->
      $(this).find("input").val(value)
  }

  "text" : {
    dom_value : (input)->
      $(input).find("textarea").val()

    set_dom_value : (value)->
      $(this).find("textarea").val(value)
  }

  "radio-button" : {
    dom_value : (input)->
      type = $(input).attr("as")
      model = $(input).attr("model")
      value = $(".input.#{type}[model='#{model}'] input:checked").val()
      value

    set_dom_value : (value)->
      type = $(this).attr("as")
      model = $(this).attr("model")
      value = $(".input.#{type}[model='#{model}'] input:checked").val()
      value
  }

  "image-radio-button" : {
    dom_value : (input)->
      window.input_types['radio-button'].dom_value(input)

    set_dom_value : (value)->
      input_types['radio-button'].set_dom_value.call(this, value)
  }

  "collection-checkboxes" : {
    dom_value : (input)->
      $input = $(input)
      $input.find(".option input:checked").map(
        (index, item)->
          return $(item).val()
      ).toArray()

    set_dom_value : (value)->
      $input = $(this)
      $input.find(".option input:checked").prop("checked", false)
      for element in value
        $input.find(".option input").filter("[value='#{element}']").prop("checked", true)
  }

  "platforms" : {
    dom_value : (input)->
      project.selected_platforms

    set_dom_value : (value)->

  }

  "tags" : {
    dom_value : (input)->
      $input = $(input)
      val = $input.find("input").val()
      if !val.length
        return []
      else
        return val.split(",")

    set_dom_value : (value)->

  }

}

window.step_types = {

  'platforms' : {
    completed : false
    checkIsCompleted : ()->
      completed = project.total_price > 0 || (project.test_platforms_bindings && project.test_platforms_bindings.length)

      completed





  }

  'project_info' : {
    checkIsCompleted : ()->
      (project.project_name && project.project_name.length) && (project.project_version && project.project_version.length) && (project.project_languages && project.project_languages.length) \
      && (project.report_languages && project.report_languages.length)
  }

  'project_components' : {
    checkIsCompleted : ()->
      (project.exploratory_instructions && project.exploratory_instructions.length)
  }

  'project_access' : {
    checkIsCompleted : ()->
      (project.project_url && project.project_url.length)
  }


}



window.wizard_form = {
  update_model_value : (value)->
    difference = diff(window.project, value)
    $.extend(window.project, value)
    $body = $("body")
    model_name = "project"
    for k,v of difference
      full_model_key = "#{model_name}.#{k}"
      $body.trigger("change.#{full_model_key}")
    $body.trigger("change.#{model_name}")



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
      @url + @get_model().id
    else
      @url + "/" + @get_model().id

  get_model : ()->
    project
  model : project
  is_persisted : ()->
    #!!@get_model().id
    !!@get_model().id
  push : ()->
    self = wizard_form
    project_data_for_push = clone(project, {
      except_keys: w("test_files test_case_files platforms selected_platforms")
    })

    data = {test: project_data_for_push}

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
          #console.log("success", arguments)
          #self.trigger("after_push")
          self.jquery_form.trigger("after_push")

          self.update_model_value(response_data)
          self.jquery_form.trigger("after_#{action}")
      }
      #console.log "opts", ajax_options
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

  $html_input = $input.find("input")
  value = $html_input.val()

  $input.addClass("checked").removeClass("unchecked")
  wizard_form.update_model_value(value)





$("body").on "change code-change keyup keypress", ".wizard [as=platforms] .option-count input", (e)->
  if e.type == "keypress"
    #console.log "e.which", e.which
    if !( (e.which >= 48 && e.which <= 57) || e.which == 8)
      #console.log "preventDefault for keypress", e.which
      #e.preventDefault()
      return false

  $input = $(this)
  original_value = $input.val()
  value = original_value
  if value == ""
    value = "0"
  if value.length > 1 && value[0] == '0'
    value = value.slice(1, value.length)
  if value != original_value
    $input.val(value)
  update_price()


update_price = ()->
  test_platforms_bindings = []
  $platforms_field = $("[as=platforms]")
  $platforms = $platforms_field.find(".platform")
  $visible_platforms = $platforms.filter(":not(.hide)")

  selected_platforms = []
  selected_platform_ids = []

  total_price = 0
  total_testers_count = 0

  $visible_platforms.each ->

    $platform = $(this)
    $platform_subitems = $platform.find(".option-count")
    #platform = {}

    platform_id = parseInt($platform.attr("data-id"))
    platform_testers_count = 0
    $platform_subitems.each ->
      $platform_subitem = $(this)
      test_platform_binding = {}
      subitem_id = parseInt($platform_subitem.attr("platform-subitem-id"))
      testers_count = parseInt($platform_subitem.find("input").val())
      platform_testers_count += testers_count
      test_platform_binding['subitem_id'] = subitem_id
      test_platform_binding['testers_count'] = testers_count

      platform_index = null

      if testers_count > 0
        test_platforms_bindings.push(test_platform_binding)


        p = selected_platforms.filter(
          (p)->
            p.id == platform_id
        )[0]

        existed = !!p

        if !p

          p ?= platforms.filter(
            (p)->
              p.id == platform_id
          )[0]

        if p
          p.testers_count = platform_testers_count

          p.hours_count = platform_testers_count * (project.hours_per_tester || 1)
          p.price = p.hours_count * price_per_hour

          if project.percentage_discount > 0
            p.price *= 1 - (project.percentage_discount / 100)
            p.price = Math.ceil(p.price)





        platform_index = selected_platform_ids.indexOf(platform_id)

        if platform_index >= 0
          selected_platforms[platform_index] = p
        else
          selected_platform_ids.push(platform_id)

          selected_platforms.push(p)



  total_price = selected_platforms.map(
    (p)->
      p.price
  ).sum()

  total_testers_count = selected_platforms.map(
    (p)->
      p.testers_count
  ).sum()

  project.total_testers_count = total_testers_count

  project.total_price = total_price

  project.test_platforms_bindings = test_platforms_bindings

  project.selected_platforms = selected_platforms

  $platforms_field.trigger("change.project.total_testers_count")


  $platforms_field.trigger("change.project.test_platforms_bindings")
  $platforms_field.trigger("change.project.total_price")
  $platforms_field.trigger("change.project.selected_platforms")
  #$platforms_field.trigger("change.#{model}")


window.input_value = ()->
  $input = $(this)
  input_type = $input.attr("as") || $input.attr("type")
  input_data_type = $input.attr("data-type")



  if !$input.filter("input").length && input_type && input_types[input_type]
    value = input_types[input_type].dom_value($input)
  else
    value = $input.val()

  if log_input_value
    console.error "input_type: ", input_type

  if input_data_type == "integer"
    value = parseInt(value)

  return value

window.validate_input = (value)->
  $input = $(this)
  input_type = $input.attr("as")
  input_type_class = input_types[input_type]
  if value == undefined
    value = input_value.call($input)

  # validation
  validation_options = {
    required: $input.hasAttribute("required")
    min: $input.attr("min")
  }

  validation_result = {}
  if validation_options.required
    if (!value || !value.length)
      validation_result.required = false
    else
      validation_result.required = true


  if input_type_class && input_type_class.validate
    r = input_type_class.validate()
    validation_result = $.extend(validation_result, r)


  invalid_classes = []
  valid_classes = []
  for k, v of validation_result
    if !v
      invalid_classes.push("invalid-#{k}")
    else
      valid_classes.push("invalid-#{k}")

  valid = invalid_classes.length == 0
  invalid = !valid



  $input.removeClass(valid_classes.join(" "))
  $input.addClass(invalid_classes.join(" "))

  if invalid
    $input.addClass("invalid")
  else
    $input.removeClass("invalid")

  # / validation

window.validate_inputs_on_init = ()->
  $(".input[model], input[model]").each ()->
    $input = $(this)

    validate_input.call($input)

$("body").on "change.project.total_price", ()->
  price = project.total_price
  $(".full-summary-total-cost .total-price").text(price)
  $("[data-bind=total_price]").text(price)
  showStepsProgress()

  $error = $("#platforms-empty-error")
  if price > 0
    $error.fadeOut()
  else
    $error.fadeIn()



$("body").on "change.project.test_platforms_bindings", (e)->
  $platforms_field = $(".wizard [as=platforms]")

  $options = $platforms_field.find(".option-count")
  $options.addClass("empty")
  if project.test_platforms_bindings && project.test_platforms_bindings.length
    for b in project.test_platforms_bindings
      $options.filter("[platform-subitem-id=#{b.subitem_id}]").removeClass("empty")

      #b.attr("platform-subitem-id")

#  platforms.filter(
#    (p)->
#      p.children.filter(
#        (subitem)->
#          return subitem.id > 10
#      ).length > 0
#  )


  # short summary

  $short_summary = $("#wizard-summary")
  $short_summary_platforms_block = $(".platforms")
  $platform_rows_block = $short_summary_platforms_block.find(".rows")
  rows = ("")
  if project.selected_platforms && project.selected_platforms.length > 0
    $short_summary_platforms_block.removeClass("hide")
    for p in project.selected_platforms

      row = \
        ("<div class='row'>
            <div class='columns large-6'>#{p.name}</div>
            <div class='columns large-3'>#{p.testers_count}</div>
            <div class='columns large-3'>#{p.hours_count}</div>
           </div>")

      rows += row

  else
    $short_summary_platforms_block.addClass("hide")

  $platform_rows_block.html(rows)



  # full summary
  $full_summary = $("#wizard-full-summary-content")
  platforms_html = ""
  if project.selected_platforms && project.selected_platforms.length

    for p in project.selected_platforms
      platform_subitems_html = ""

      selected_children = p.children.filter(
        (subitem)->
          project.test_platforms_bindings.map(
            (b)->
              b.subitem_id
          ).indexOf(subitem.id) >= 0
      )

      p.selected_children = selected_children

      subitems_html = ""

      for subitem in p.selected_children

        subitem_html = "<div class='platform-subitem'>#{subitem.name}</div>"

        subitems_html += subitem_html

      platform_html = "
            <div class='columns large-4 platform'>
              <div class='platform-svg'></div>
              <div class='platform-name'>#{p.name}</div>
              <div class='platform-subitems'>#{subitems_html}</div>
            </div>
          "



      platforms_html += platform_html

  $full_summary.find(".platforms").html(platforms_html)


#$("body").on "change", "input[model]", ()->
#  $input = $(this)
#  model = $(this).attr("model")
#  value = null
#  type = $(this).attr("type")
#  if type.in(w("text url tel")) || type.in(w("radio"))
#    value = $input.val()
#  else
#
#  assign_model_key(model, value)
#  notifyProjectHasUnsavedChanges()
#  $input.trigger("change.#{model}")

window.check_for_step_completeness = ()->
  $step = $(this)
  step_type = $step.attr("type")

  #console.log "step_type: ", step_type
  #console.log "check_for_step_completeness:: before if", step_type
  if step_types[step_type]
    #console.log "check_for_step_completeness:: inside if"
    completed = step_types[step_type].checkIsCompleted.apply($step)

    data_completed = $step.data("completed")
    if data_completed != completed
      $step.data('completed', completed)
      if completed
        $step.addClass("completed")
        $step.trigger("step_completed")

      else
        $step.removeClass("completed")
        $step.trigger("step_uncompleted")






$("body").on "change keyup dom_change", ".input[model], input[model]", (e)->
  #console.log "e : #{e.type}", e
  $input = $(this)
  model = $input.attr("model")

  value = input_value.call($input)
  #console.log "inspect: model: #{model}: ", value

  validate_input.call($input, value)
  assign_model_key(model, value)

  #console.log "input change"

  project.saved = false

  disabled_trigger_changes = $input.attr("trigger-changes") == "false"
  if !disabled_trigger_changes
    notifyProjectHasUnsavedChanges()

  $input.trigger("change.#{model}")

  $wizard_controller = $(".wizard-controller")

  $step = $(this).closest(".wizard-step")
  check_for_step_completeness.apply($step)



  stringified_value = value
  if Array.isArray(value)
    stringified_value = value.join(", ")

  $("[data-bind='#{model}']").text(stringified_value)

  disabled_push = $input.attr("push") == 'false'


  if !disabled_push && wizard_form.is_persisted.apply(wizard_form)
    save_timeout_id = $wizard_controller.data("save_timeout_id")
    console.log "inspect: project_main_components: ", project.main_components
    if save_timeout_id
      clearTimeout(save_timeout_id)
    save_timeout_id = setTimeout(
      ()->
        wizard_form.push.apply(wizard_form)
      2000
    )

    $wizard_controller.data("save_timeout_id", save_timeout_id)
  enable_checkout_button_if_project_valid()
#  valid_project = $(".configuration-steps .wizard-step:not(.hide):not(.completed)").length == 0
#  $checkout_button = $(".checkout-button, .rf-confirm-button")
#  if valid_project
#    $checkout_button.removeAttr("disabled")
#  else
#    $checkout_button.attr("disabled", "disabled")



$("body").on "change.project.total_testers_count", ()->
  model = "project.total_testers_count"
  value = project.total_testers_count
  $("[data-bind='#{model}']").text(value)






#$("body").on "change", ".wizard .input.radio-button", ()->


scrollToFirstStep = ()->
  change_step(2, null, false)
  scrollToStep(2)


scrollToStep = (step_id)->
  if step_id == undefined || step_id == null
    return
  $visible_steps = $(".configuration-steps .wizard-step:not(.hide)")




  available_step = project.available_step_ids.indexOf(step_id) >= 0

  if available_step
    $visible_steps.filter(".wizard-step[step=#{project.current_step_id}]")

    top = $visible_steps.filter("[step=#{step_id}]").offset().top - $("#header").height() - 50

    #console.log "top: ", top
    $("html, body").animate({scrollTop: top})

    return true

show_mini_summary = ()->
  $("#wizard-summary .footer").removeClass("hide")




window.showStepsProgress = ()->
  $visible_steps = $(".configuration-steps .wizard-step:not(.hide)")
  progress_steps_str = ""
  steps_count = $visible_steps.length
  step_percentage_width = "#{100 / steps_count}%"
  $visible_steps.each ()->

    $step = $(this)
    completed = !!$step.data("completed")
    step_id = $step.attr("step")

    $progress_step = $("steps-progress .step[step=#{step_id}]")
    if completed
      $progress_step.addClass("proceeded")
    else
      $progress_step.removeClass("proceeded")

    step_html = "<div step='#{step_id}' class='step #{'proceeded' if completed}' style='width: #{step_percentage_width}'><div class='inner'></div></div>"
    progress_steps_str += step_html

  $("steps-progress .progress").html(progress_steps_str)



notifyProjectSaved = ()->
  $(".save-button").hide()
  $(".project-saved").fadeIn()

window.notifyProjectHasUnsavedChanges = ()->
  $(".project-saved").hide()
  $(".save-button").fadeIn()


$("body").on "click", ".save-button", ()->
  wizard_form.push.apply(wizard_form)

next_step = ()->
  $current_step = $(".wizard-step[step=#{project.current_step_id}]")
  next_step_id = project.next_step_id
  if next_step_id

    change_step(next_step_id, $current_step, false)
    scrollToStep(next_step_id)



prev_step = ()->
  $current_step = $(".wizard-step[step=#{project.current_step_id}]")
  prev_step_id = project.prev_step_id
  if prev_step_id

    change_step(prev_step_id, $current_step, false)
    scrollToStep(prev_step_id)


$("body").on "click", ".go-back-button", ()->
  prev_step()




$("body").on "click", ".rf-next-step-button", ()->
  step = next_step()
#  if !step
#    $button = $(this)
#    $button.fadeOut()

$("body").on "change", ".project_test_type", ()->
  if is_configure_mode()
    hide_unavailable_steps()
    showStepsProgress()




$("body").on "change", ".project_product_type", ->
  hide_unavailable_platforms()



show_full_summary = ()->
  $("#wizard-full-summary").removeClass("hide")

is_configure_mode = ()->
  $wizard_controller.hasClass("configure-mode")



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
  project.test_type || $("[model*=test_type].checked").attr("value").toLowerCase()

hide_unavailable_steps = ()->
  $step = $(".project-components-step")
  test_type_name = get_test_type_name()
  $next_step = $step.next()
  if test_type_name.toLowerCase() == 'functional' || test_type_name.toLowerCase() == 'localization'
    $step.removeClass("hide")
    $next_step.find(".wizard-step-counter").attr("data-number", 4)
    project.last_step_index = 3
  else
    $step.addClass("hide")
    $next_step.find(".wizard-step-counter").attr("data-number", 3)
    project.last_step_index = 2

$("body").on "click", ".option-count .decrement, .option-count .increment", ->
  $btn = $(this)
  increment = $btn.hasClass("increment")
  decrement = !increment
  $input_wrap = $btn.closest(".input-wrap")
  $option_count = $input_wrap.closest(".option-count")
  $platforms_input = $option_count.closest("div.platforms-input")
  if $platforms_input.hasClass("touched")
    $platforms_input.addClass("touched")
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


set_presence_class = ()->
  $input = $(this)
  if $input.hasClass("string") || $input.hasClass("tags")
    val = $input.find("input").val()
  else
    val = $input.find("textarea").val()


  if $input.hasClass("tags")
    console.log "tags: ", is_present(val)



  if is_present(val)
    $input.addClass("not-empty").removeClass("empty")
  else
    $input.addClass("empty").removeClass("not-empty")

inputs_selector_for_presence =  ".input.string, .input.text, .input[as=tags]"

$("body").on "change keyup", inputs_selector_for_presence, ()->
  set_presence_class.call(this)



$("body").on "focus focusin focusout", ".input", (e)->
  $input = $(this)
  if e.type == 'focusout' && !$input.hasClass("touched")
    $input.addClass("touched")
    $input.trigger("touched")
  if e.type == 'focusin' || e.type == 'focus'
    $input.addClass("focus")
  else
    $input.removeClass("focus")

  #console.log "e", e.type
  if e.type == 'focusin' || e.type == 'focus'
    $step = $input.closest(".wizard-step")
    step_id = parseInt($step.attr("step"))
    change_step(step_id, $step, false)


$("body").on "click", ".input.collection-checkboxes", ()->
  $input = $(this)
  $input.addClass("touched")




change_step = (step_id, $current_step = null, check_for_current_step_id = true)->
  if !check_for_current_step_id || step_id != project.current_step_id

    # validate current step before change
    $current_step ?= $(".wizard-step[step=#{project.current_step_id}]")
    $current_step.addClass("changed-from-this")
    $current_step.find(".input").each ()->
      $input = $(this)
      validate_input.call($input)

    #console.log "change_step: step_id: ", step_id
    project.current_step_id = step_id

    $visible_steps = $(".configuration-steps .wizard-step:not(.hide)")
    available_step_ids = $visible_steps.map(
      (index, item)->
        local_step_id = $(item).attr("step")
        if local_step_id == undefined  || local_step_id == null
          return null
        return parseInt(local_step_id)
    ).toArray()

    project.available_steps = []


    project.available_step_ids = available_step_ids


    available_next_step = available_step_ids.indexOf(step_id) < available_step_ids.length - 1
    available_prev_step = available_step_ids.indexOf(step_id) > 0

    $target = $current_step
    if !$target || !$target.length
      $target = $("body")



    #if project.available_next_step
    changed_available_next_step = available_next_step != project.available_next_step
    project.available_next_step = available_next_step

    if available_next_step
      project.next_step_id = available_step_ids[available_step_ids.indexOf(step_id) + 1]
    else
      project.next_step_id = null

    if changed_available_next_step
      $target.trigger("change.project.available_next_step")




    changed_available_prev_step = available_prev_step != project.available_prev_step
    project.available_prev_step = available_prev_step
    if available_prev_step
      project.prev_step_id = available_step_ids[available_step_ids.indexOf(step_id) - 1]
    else
      project.prev_step_id = null

    if changed_available_prev_step
      $target.trigger("change.project.available_prev_step")


    #console.log "status", { available_step_ids: available_step_ids, available_next_step: available_next_step, next_step_id: project.next_step_id, available_prev_step: available_prev_step, prev_step_id: project.prev_step_id }


    $target.trigger("change.project.current_step_id")


$("body").on "change.project.current_step_id", ()->
  step_id = project.current_step_id
  $step = $(".wizard-step[step=#{step_id}]")
  $(".wizard-step.active").removeClass("active")
  $step.addClass("active")
  number = $step.find(".wizard-step-counter").attr("data-number")
  if !project.next_step_id
    $(".rf-next-step-button").hide()
    $(".rf-go-to-summary-button").fadeIn()
  else
    $(".rf-go-to-summary-button").hide()

    $(".rf-next-step-button").fadeIn()


  #alert((project.current_step_id).toString())
  if !!project.current_step_id
    $mini_summary_large_confirm_button = $("#wizard-summary .rf-confirm-button")
    $mini_summary_large_confirm_button.hide()
  else
    $(".rf-go-to-summary-button").hide()


$("body").on "click", ".rf-go-to-summary-button", ()->
  $(".wizard-step.active").removeClass("active")
  top = $("#wizard-full-summary").offset().top - $("#header").height() - 50
  $("html, body").animate({scrollTop: top})

  project.prev_step_id = project.current_step_id
  project.current_step_id = null

  $button = $(this)
  $button.hide()

  $mini_summary_large_confirm_button = $("#wizard-summary .rf-confirm-button")

  $mini_summary_large_confirm_button.fadeIn()


$("body").on "change.project.available_next_step", ()->
  if project.available_next_step
    $(".rf-next-step-button").fadeIn()
  else
    $(".rf-next-step-button").fadeOut()

$("body").on "change.project.available_prev_step", ()->
  $go_back_wrap = $(".or-go-back-wrap")
  if project.available_prev_step
    $go_back_wrap.removeClass("hide")
    $go_back_wrap.fadeIn()
  else
    $go_back_wrap.fadeOut()

init_string_inputs = ()->
  $(".input.string").each ->
    $input = $(this)
    val = $input.find("input").val()
    if is_present(val)
      $input.addClass("not-empty")
    else
      $input.removeClass("not-empty")

init_tags_input = ()->
  $input = $('.input[model="project.main_components"] input')
  val = $input.val()
  $input_wrap = $input.closest(".input")

  console.log "init_tags_input: ", is_present(val)

  if is_present(val)
    $input_wrap.addClass("not-empty").removeClass("empty")
  else
    $input_wrap.addClass("empty").removeClass("not-empty")

  $input.tagsInput({
    defaultText: ""
    onRemoveTag: ()->
      $html_input = $(this)
      $input = $html_input.closest(".input")
      #alert("tag removed: res: #{$html_input.val()}")
      $html_input.trigger("change")

    onAddTag: ()->
      $html_input = $(this)
      $input = $html_input.closest(".input")
      $html_input.trigger("change")
    onChange: ()->
      $html_input = $(this)
      $input = $html_input.closest(".input")
      $html_input.trigger("change")
      empty = !($input.children().filter("input").val().length)
      if empty
        $input.addClass("empty").removeClass("not-empty")
      else
        $input.addClass("not-empty").removeClass("empty")
  })


$("body").on "click", ".input.image-radio-button", ()->
  $(this).trigger("focusin")



$("body").on "click", ".input.tags label", ()->
  $input = $(this).closest(".input")
  $input.find("div.tagsinput").trigger("click")



$("body").on "change.project.product_type", ()->
  $project_test_type = $("#project-test-type")
  if project.product_type
    $project_test_type.fadeIn()
  if small() && !project.test_type
    top = $project_test_type.offset().top
    $("body").animate({scrollTop: top})


$("body").on "change.project.test_type", ()->
  if project.test_type
    $("#project-product-type").fadeIn()
    $(".rf-configure-button, .rf-step-configure-button").fadeIn()


  enable_checkout_button_if_project_valid()

  $exploratory_instructions_block = $("#wizard-full-summary .exploratory_instructions_block")
  if wizard_form.is_persisted.apply(wizard_form) && project.methodology_type == "exploratory"
    $exploratory_instructions_block.fadeIn()

  else
    $exploratory_instructions_block.fadeOut()

$("body").on "change.project.product_type", ()->
  #if project.product_type
  #  $(".rf-configure-button").fadeIn()

  if wizard_form.is_persisted.apply(wizard_form)
    update_price()
    $platforms_step = $(".wizard-step[type=platforms]")
    step_types['platforms'].checkIsCompleted.apply($platforms_step)
    showStepsProgress()


    #wizard_form.update_model_value({valid: valid_project})
    #origginal_valid = !!project.valid
    #if origginal_valid

window.get_test_invalid_steps = ()->
  $(".configuration-steps .wizard-step:not(.hide):not(.completed)")

is_valid_project = (steps)->

  valid_project = wizard_form.is_persisted.apply(wizard_form)
  if valid_project
    if !steps
      steps = get_test_invalid_steps()
    valid_project = steps.length == 0

  return valid_project

#$("body").on "change.project.valid", ()->
enable_checkout_button_if_project_valid = ()->

  $checkout_button = $(".checkout-button, .rf-confirm-button")
  disabled_when_test_has_errors = false
  if disabled_when_test_has_errors
    if is_valid_project()
      $checkout_button.removeAttr("disabled")
    else
      $checkout_button.attr("disabled", "disabled")



$("body").on "change.project.authentication_required", ()->
  show_or_hide_auth_credentials_inputs()


$("body").on "change.project.methodology_type", ()->
  show_or_hide_exploratory_instructions_input()

show_or_hide_exploratory_instructions_input = ()->
  testing_type = $(".input[model*='project.methodology_type'] input:checked").val()
  $input = $(".project_exploratory_instructions_input")

  $file_input = $(".test-case-files-input")
  $test_case_inputs_wrap = $("#test-case-driven-inputs-wrap")

  if testing_type == 'exploratory'
    #console.log "testing_type(exploratory)", testing_type
    $input.removeClass("hide")
    #$file_input.addClass("hide")
    $test_case_inputs_wrap.addClass("hide")
  else
    #console.log "testing_type(not-exploratory)", testing_type
    $input.addClass("hide")
    #$file_input.removeClass("hide")
    $test_case_inputs_wrap.removeClass("hide")

show_or_hide_auth_credentials_inputs = ()->
  requires_auth = $("[model*='project.authentication_required'] input:checked").val() == 'true'
  $input = $(".project_exploratory_instructions_input")

  $credentials_inputs = $(".project-auth-login, .project-auth-password")

  if requires_auth
    $credentials_inputs.removeClass("hide")
  else
    $credentials_inputs.addClass("hide")


show_or_hide_auth_test_driven_development_inputs = ()->
  methodology_type = $("[model*='project.methodology_type'] input:checked").val() == 'true'
  $input = $("#test-case-driven-inputs-wrap")

  $another_inputs = $(".project-auth-login, .project-auth-password")

  if methodology_type = "exploratory"
    $another_inputs.addClass("hide")
  else
    $another_inputs.removeClass("hide")






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

    $list.append("<div class='file' data-temp-id='#{$list.children().length + 1}' data-file-name='#{file.name}'><span class='file-name'>#{file.name}</span><span class='preloader'></span><span class='delete'></span></div>")
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


  data_start_temp_id = ($list.children().last().attr("data-temp-id")  || 0) + 1
  $input.simpleUpload("#{wizard_root_path}/#{project.id}/#{attachment_name}?data-temp-id-start=#{data_start_temp_id}", {

    success: (data)->
      file_name = data.data_file_name
      $file = $list.children().filter(":not(.loaded)").filter("[data-file-name='#{file_name}']")
      $file.attr("data-id", data.id)
      $file.addClass("loaded")
      $file.find("span.preloader").hide()

  })


  $input.trigger("upload_files.#{attachment_name}")



$("body").on "click", ".file-upload-files-list .delete", ->
  console.log "delete 1"

  $file = $(this).closest('.file')
  file_index = $file.index()
  asset_id = $file.attr("data-id")
  $list = $file.closest(".file-upload-files-list")
  $file.remove()
  assets.test_case_files.splice(file_index, 1)

  attachment_name = $list.attr("data-attachment-name")
  $.ajax({
    url: "#{wizard_root_path}/#{project.id}/#{attachment_name}/#{asset_id}"
    type: "delete"
    dataType: "json"

  })

  $list.trigger("delete_files.#{attachment_name}")

  console.log("delete 2")



$("body").on "click", ".rf-test-case-files-upload-button", (e)->
  $input = $("input#test_case_files")
  $input.click()

$("body").on "click", ".rf-wizard-test-files-upload-button", (e)->
  e.stopImmediatePropagation()
  e.preventDefault()
  $input = $("input#test_files")
  $input.click()





#$("body").on "disappear", ".wizard-step", ()->
#  $(this)

$("body").on "after_push", ()->
  notifyProjectSaved()

$("body").on "after_create", ()->
  state = {}
  title = ""
  url = wizard_form.update_url.apply(wizard_form)
  history.pushState(state, title, url);

$("body").on "click", ".rf-configure-button, .rf-step-configure-button", ()->
  $(".rf-step-configure-button").attr("style", "")
  $(".rf-step-configure-button").fadeOut()
  init_configure_mode()
  scrollToFirstStep()
  wizard_form.push.apply(wizard_form)
  notifyProjectSaved()

init_configure_mode = ()->
  $wizard_controller.addClass("configure-mode")
  hide_unavailable_steps()
  showStepsProgress()
  hide_unavailable_platforms()
  show_full_summary()
  show_mini_summary()

init_loaded_project = ()->
  str = $wizard_controller.attr("test-json")
  if str
    data = JSON.parse(str)
    $.extend(window.project, data)


  if wizard_form.is_persisted.apply(wizard_form)
    init_configure_mode()

    #console.log "loaded_project: ", project
    #console.log "test1"
    change_step(project.current_step_id, null, false)
    #console.log "test2"
    scrollToStep(project.current_step_id)

    #console.log "test3"

    #console.log "project", project

    $(".input[model][as]").each ()->
      $input = $(this)
      type = $input.attr("as")
      model = $input.attr("model")
      value = byString(model);
      current_value = input_types[type].dom_value($input)
      if value != current_value
        input_types[type].set_dom_value.call($input, value)
        $input.trigger("change")
        $input.trigger("dom_change")
        $input.trigger("change.#{model}")



$("body").on "step_completed step_uncompleted", ".wizard-step", (e)->

  $step = $(this)
  step_id = $step.attr("step")
  $progress_step = $("steps-progress .progress .step[step=#{step_id}]")
  if e.type == 'step_completed'
    $progress_step.addClass("proceeded")
  else
    $progress_step.removeClass("proceeded")

  #console.log "e.type: ", e.type
  #console.log "step_id: ", step_id

init_option_count_inputs = ()->
  if Modernizr.touchevents
    $("body .option-count input").attr("type", "number")

log_project_access_test_url_and_files = false

validate_project_access_test_url_and_files = ()->
  valid = (project.project_url && project.project_url.length > 0 ) || $(".test_files-list").children().length > 0
  if log_project_access_test_url_and_files
    console.log "validate_project_access_test_url_and_files: ", valid
  $error = $("#test-url-or-files-required-error")


  if valid
    $error.fadeOut()
  else
    $error.fadeIn()

$("body").on "upload_files.test_files delete_files.test_files change.project.project_url", ()->
  validate_project_access_test_url_and_files()

$("body").on "delete_files.test_files", ()->
  console.log "delete 3"

# initialize wizard

window.project ?= {}
window.platforms = JSON.parse($("[as=platforms]").attr("options"))
init_loaded_project()
#update_price()

init_option_count_inputs()
check_for_step_completeness.apply($('.wizard-step[type=platforms]'))
showStepsProgress()
#console.log "platform_bindings: ", project.test_platforms_bindings
#console.log "total_price: ", project.total_price

validate_inputs_on_init()
$(inputs_selector_for_presence).each ()->
  set_presence_class.call(this)

init_string_inputs()



# step 3
show_or_hide_exploratory_instructions_input()

init_tags_input()


# step 4
show_or_hide_auth_credentials_inputs()



$(".hour").filter("[data-hours=#{project.hours_per_tester}]").addClass("selected")



$(".wizard-step").on "disappear", ()->
  #console.log "disappear"
  $wizard_full_summary = $("#wizard-full-summary")
  active_summary = $wizard_full_summary.filter(":appeared").length > 0

  if active_summary
    project.current_step_id = null
    project.prev_step_id = project.available_step_ids[project.available_step_ids.length]
    project.next_step_id = false
  #else


#$(window).on "scroll", ()->
  #$wizard_full_summary = $("#wizard-full-summary")
  #active_summary = $wizard_full_summary.filter(":appeared").length > 0

  #if active_summary
  #  console.log "active_summary"



$("body").on "change.project.hours_per_tester", ()->
  $hour_labels = $(".hour")
  $hour_labels.filter(".selected").removeClass("selected")
  $hour_labels.filter("[data-hours=#{project.hours_per_tester}]").addClass("selected")
  #console.log "project.hours_per_tester", project.hours_per_tester



$("body").on "keyup", ".input[as=tags]", ()->


$("body").on "click", ".promo-code-field button", ()->
  $button = $(this)
  $promo_code_field = $button.closest(".promo-code-field")
  $label = $promo_code_field.find("label")
  $invalid_code_error = $(".error-invalid")
  $input = $promo_code_field.find("input")
  $waiting_label = $promo_code_field.find(".waiting")

  password = $input.val()

  data = { promo_code: { password: password } }
  url = $("form[for=project]").attr("url") + "/" + project.id + "/promo_code"
  $.ajax(
    data: data
    dataType: 'json'
    type: "post"
    url: url
    success: (res)->
      project.percentage_discount = res.percentage_discount
      $promo_code_field.removeClass("waiting invalid")
      $promo_code_field.addClass("success")
      $(".percentage-discount").text(project.percentage_discount)
      update_price()
#      setTimeout(
#        ()->
#          $promo_code_field.addClass("hide")
#
#        3000
#      )

    error: ()->
      #$label.hide()
      #$invalid_code_error.show()
      $promo_code_field.removeClass("waiting")
      $promo_code_field.addClass("invalid")



      $input.removeAttr("disabled")

  )

  $promo_code_field.addClass("waiting")
  $input.attr("disabled", "disabled")


$(".checkout-button, .rf-confirm-button").on "click", (e)->
  $button = $(this)
  $invalid_test_steps = get_test_invalid_steps()
  if !is_valid_project($invalid_test_steps)
    $popup = $("#invalid_fields_popup")
    openPopup($popup)
    $invalid_steps_list = $popup.find("div.invalid-steps-list")
    invalid_steps_list_items_html = ""
    $invalid_test_steps.each ()->
      $step = $(this)
      step_name = $step.attr("data-name")
      step_number = $step.find(".wizard-step-counter").attr("data-number")
      step_id = $step.attr("step")

      invalid_fields_html = ""

      $fields = $step.find(".input.invalid, :not(.input) .error:visible")
      $fields.filter(".input").addClass("touched")
      $fields.each ()->

        $this = $(this)
        $field = $this

        if $this.filter(".error").length
          if $this.closest(".input").length > 0
            return

        if $this.filter(".input").length
          field_name = $field.attr("data-name") || $field.find(".placeholder").text()
          field_html_id = $field.attr("id") || $field.attr("data-input-id") || $field.find("input, textarea").attr("id")
        else if $this.filter(".error").length
          field_name = $field.attr("data-field-name") || $field.attr('data-group-name') || $field.text()
          field_html_id = $field.attr("for") || $field.attr("data-input-id")




        if field_html_id
          field_link = "##{field_html_id}"
        else
          field_link = false

        href_str = ""
        if field_link
          href_str = "href='#{field_link}'"

        invalid_fields_html += "<div><a class='invalid-field-link' #{href_str}>#{field_name}</a></div>"



      invalid_steps_list_items_html += "<div step-id='#{step_id}' class='step'><div class='step-number' data-number='#{step_number}'></div><div class='step-name'>#{step_name}</div><div class='invalid-fields-list'>#{invalid_fields_html}</div></div>"

    $invalid_steps_list.html(invalid_steps_list_items_html)
    return false


$(".popup.invalid-fields").on "click", ".invalid-field-link", (e)->
  $link = $(this)
  e.preventDefault()
  $link.closeDialog()
  selector = $link.attr("href")
  scroll_to_step = true
  $target = null
  if scroll_to_step
    step_id = $link.closest("div.step").attr("step-id")
    $target = $(".wizard-step").filter("[step=#{step_id}]")
  else
    $target = $(selector)


  top = $target.offset().top - 128


  $("body").animate(scrollTop: top)


