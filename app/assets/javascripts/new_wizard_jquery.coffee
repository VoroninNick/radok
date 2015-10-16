$wizard_controller = $("#wizard-controller")
window.wizard = {
  active_step_number: 1
  proceeded_steps_count: 0
  total_steps_count: null
}

validate_before_change_step = false

basicValidate = (step_number)->
  $step = $(".wizard-step[step-number=#{step_number}]")
  return $step.find(".rf-input.invalid").length == 0

window.configuration_steps = [
  {


    initialize: ()->
      $platform_items = $(".wizard-platforms-step").find("platform")



      $platform_items.each ->
        $platform = $(this)
        platform_product_ids = $platform.attr("data-product-type-ids").split(',')
        if platform_product_ids.indexOf(product_type_id.toString()) >= 0
          $platform.removeClass("hide")
        else
          $platform.addClass("hide")

      $platform_items.filter(":not(.hide)").each (index, item)->
        if index % 2 == 0
          $(item).addClass('first')
        else
          $(item).removeClass('first')
    validate: ()->
      return getTotalPrice() > 0
    serialize: ()->
      return serializePlatforms()

  }
  {

  }
]


wizard.price_per_hour = 20
wizard.hours_count = 1


created = false
saving_in_progress = false

saveTest = ()->
  if !saving_in_progress
    if !created
      data = {test: $(".intro-step form").serializeObject()}
      saving_in_progress = true
      $.ajax(
        url: wizard_root_path
        type: "post"
        dataType: "json"
        data: data
        complete: ->
          saving_in_progress = false
        success: (data)->
          $.extend(wizard, data)
          created = true
          window.history.pushState({}, "", "#{wizard_root_path}/#{data.id}")
      )



    else
      serializeTest()
      data = { test: wizard}
      saving_in_progress = true
      $.ajax(
        url: "#{wizard_root_path}/#{wizard.id}"
        type: "put"
        data: data
        dataType: "json"
        complete: ->
          saving_in_progress = false
        success: ()->
          $(window).trigger("test_saved")
      )

$("body").on "click", ".save-button", ->
  saveTest()


window.scrollToStep = (step_number)->
  $step = $(".wizard-step[step-number=#{step_number}]")
  $step.addClass("activated")

  step_top = $step.offset().top
  top_for_scroll = step_top - 80
  $('body').animate(scrollTop: top_for_scroll)



$.fn.validateStep = ()->
  $form = $(this).find("form")

  $form.validateForm()

$("body").on "change keyup", ".wizard-step input", ()->
  $input = $(this)
  $rf_input = $input.closest(".rf-input")
  $form = $rf_input.closest("form")
  #$form.validateForm()
  valid = $form.find(".rf-input.invalid").length == 0
  $rf_next_step_button = $(".rf-next-step-button")
  $step = $form.closest(".wizard-step")
  step_number = parseInt($step.attr("step-number"))
  if wizard.active_step_number == step_number
    if valid
      $rf_next_step_button.removeAttr("disabled")
    else
      $rf_next_step_button.attr("disabled", "disabled")

editStep = (step_number, save = true, validate = false)->


  $active_step = $(".wizard-step.active")
  $active_step.removeClass("active")
  $active_step.addClass("proceeded")
  $active_wizard_step_wrap = $active_step
  $requested_step = $(".wizard-step[step-number=#{step_number}]")
  $requested_step.addClass("active")
  $requested_step.validateStep()

  if wizard.total_steps_count == step_number
    $(".rf-next-step-button").addClass("hide")
  scrollToStep(step_number)
  configuration_step = configuration_steps[step_number - 1]

  if validate
    valid = basicValidate(step_number)

    if valid && configuration_step && configuration_step.validate
      valid = configuration_step.validate()
    console.log "valid_step ", valid
    #console.log("valid:", valid)
    if !valid
      $(".rf-next-step-button").attr("disabled", "disabled")
    else
      console.log("valid")
      $(".rf-next-step-button").removeAttr("disabled")

  else
    $(".rf-next-step-button").removeAttr("disabled")


  wizard['active_step_number'] = step_number
  if wizard.proceeded_steps_count < step_number - 1
    wizard.proceeded_steps_count = step_number - 1
  if save
    saveTest()

  if configuration_step && configuration_step.initialize
    configuration_step.initialize()

  #presentProgressSteps()


window.presentProgressSteps = ()->
  $progress_steps = $("#wizard-summary .progress .step")

  $progress_steps.filter(":lt(#{wizard.proceeded_steps_count})").addClass("proceeded")

nextStep = ()->
  local_step_number = wizard.active_step_number + 1
  if $(".configuration-steps .wizard-step").length > wizard.proceeded_steps_count
    wizard.proceeded_steps_count = wizard.proceeded_steps_count + 1
  editStep(local_step_number)



#$("#wizard-full-summary").addClass("hide")

$(".rf-next-step-button").on "click", ->
  nextStep()

$("body").on "click", ".wizard-step-edit-tooltip, .wizard-step-counter", ->
  $edit_tooltip = $(this)
  $wizard_step = $edit_tooltip.closest(".wizard-step")
  requested_step_number = parseInt($wizard_step.attr("step-number"))
  editStep(requested_step_number)

configure = ()->

  $wizard_controller.addClass("configure-mode")
  $(".intro-step").removeClass("active").addClass("proceeded")
  $("[data-bind=tot__type_of_test]").each ->
    $this = $(this)
    val = $("input[name=test_type]:checked").attr("data-name") || wizard.test_type_name
    if val != wizard.test_type_name
      wizard.test_type_name = val
    $this.text(val)


  $("[data-bind=top__type_of_product]").each ->
    $this = $(this)
    val = $("input[name=product_type]:checked").attr("data-name") || wizard.product_type_name
    if val != wizard.product_type_name
      wizard.product_type_name = val
    $this.text(val)

  $summary_footer =  $("#wizard-summary .footer")
  $summary_footer.removeClass("hide")

  $(".configuration-steps").removeClass("hide")

  wizard.total_steps_count = $(".configuration-steps").find(".wizard-step").length



  window.product_type_id = parseInt($('question[question-key=type_of_product] input:checked').attr('data-id'))

  #$(".wizard-platforms-step").find("platform").each ->
  #  $platform = $(this)
  #  if !$platform.hasClass("in-group")

  $("#wizard-full-summary").removeClass("hide")



$(".rf-configure-button").on "click", ->

  configure()



  scrollToStep(1)
  saveTest()
  editStep(1)


$(".option-count").on "click", ".decrement, .increment", ->
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

$("body").on "check uncheck", ".hours-per-tester input", (event)->
  #console.log event.type
  $hours_per_tester = $(".hours-per-tester")
  $input = $(this)
  hour = parseInt($input.val())
  $label = $input.closest("label")

  if event.type == 'check'
    $label.addClass("selected")
    wizard.hours_count = parseInt($(this).val())
    updatePrice()
  else
    $label.removeClass("selected")



$(".option-count").on "change code-change", "input", ->
  $input = $(this)
  $option_count = $input.closest(".option-count")
  value = parseInt($input.val()) || 0
  if value > 0
    $option_count.removeClass("empty")
  else
    $option_count.addClass("empty")


$("body").on "change code-change", '.wizard-platforms-step platform:not(.hide) .platform-content .option-count input', ->
  $input = $(this)
  $platforms_step = $(this).closest(".wizard-step.wizard-platforms-step")
  $platform = $input.closest("platform")
#  platform_testers_count = $platform.find(' .platform-content .option-count input:present').map((index, item)->
#    return parseInt($(item).val())
#  ).toArray().sum()
#
#  platform_price = platform_testers_count * wizard.hours_count * wizard.price_per_hour
#
#  $platform_price = $platform.find(".platform-price .price.ng-binding")
#  $platform_price.text(platform_price)

  presentPlatformPrice.call($platform)
  presentTotalPrice()


calculatePriceByPlatform = ()->

window.getPlatformPrice = ()->
  $platform = $(this)
  platform_testers_count = $platform.find(' .platform-content .option-count input:present').map((index, item)->
    return parseInt($(item).val())
  ).toArray().sum()

  platform_price = platform_testers_count * wizard.hours_count * wizard.price_per_hour

  return platform_price

window.presentPlatformPrice = ()->
  $platform = $(this)
  platform_price = getPlatformPrice.call(this)
  $platform_price = $platform.find(".platform-price .price.ng-binding")
  $platform_price.text(platform_price)



window.getTotalPrice = ()->
  #wizard.hours_count
  $platforms = $(".wizard-platforms-step platform:not(.hide)")
  total_price = $platforms.map((index, item)->
    getPlatformPrice.call(item)
  ).toArray().sum()

  return total_price

presentTotalPrice = ()->
  console.log "wizard.active_step_number", wizard.active_step_number
  total_price = getTotalPrice()
  $summary_footer =  $("#wizard-summary .footer")

  $rf_next_button = $(".rf-next-step-button")
  if wizard.active_step_number == 1
    if total_price > 0
    #  $summary_footer.removeClass("hide")
      $rf_next_button.removeAttr("disabled")
    else
    #  $summary_footer.addClass("hide")
      $rf_next_button.attr("disabled", "disabled")
  $("[data-bind=total_price]").text(total_price)



updatePrice = ()->
  presentTotalPrice()
  $platforms = $(".wizard-platforms-step platform:not(.hide)")
  $platforms.each ->
    presentPlatformPrice.call(this)




$(document).on "ready", ->
  #fixChromeAutocompleteBug()

  window.test_types = $("#wizard-controller").attr("data-test-type-names")


  test_json_str = $wizard_controller.attr('test-json')
  if test_json_str != undefined
    $.extend wizard, $.parseJSON(test_json_str)
  wizard.test_type_name = $("[name=test_type_id]:checked").attr("data-name")
  wizard.product_type_name = $("[name=product_type_id]:checked").attr("data-name")
  $(".option-count input:blank").each ->
    $this = $(this)
    old_val = $this.val()
    if(old_val != 0)
      $this.trigger_val(0)

  $('input.tags-input').tagsInput();
  $('.rf-input[type=tags] input').tagsInput({
    defaultText: ""
    onChange: ()->
      $rf_input = $(this).closest(".rf-input")
      $rf_input.trigger("change")
  })

  step_number = wizard.active_step_number

  $(".configuration-steps .wizard-step:lt(#{wizard.proceeded_steps_count})").addClass("proceeded")

  $(".wizard-step:not()").addClass("")

  if $(".configure-mode").length
    configure()
    editStep(step_number, false)

#$("body").on "check uncheck", "input", (event)->
#  console.log "event: ", event

#$("body").on "change code-change", "input", (event)->
#  console.log event.type
#
#
#  $('button').on "click", ->
#    $(document).trigger("ready")

$("body").on "click", ".rf-test-case-files-upload-button", ()->
  $input = $("input#test_case_files")
  $input.click()

$("body").on "click", ".rf-wizard-test-files-upload-button", ()->
  $input = $("input#test_files")
  $input.click()

window.assets ?= {}
window.assets.test_case_files ?= []

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

  $input.simpleUpload("#{wizard_root_path}/#{wizard.id}/#{attachment_name}", {
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


window.serializePlatforms = ()->
  platforms = []

  $('platform:not(.hide) .option-count input').each ->
    $input = $(this)
    count = parseInt($input.val())
    if count > 0
      platform_id = parseInt($input.closest(".option-count").attr("data-id"))
      platforms.push({id: platform_id, count: count})

  wizard['platforms'] = platforms
  return platforms

window.serializeProjectInfo = ()->
  $step = $(".wizard-project-info-step")
  $form = $step.find("form")
  project_info = $form.serializeObject()
  $.extend wizard, project_info

  project_info

window.serializeTest = ()->
  serializePlatforms()
  serializeProjectInfo()


fixChromeAutocompleteBug = ->
  if navigator.userAgent.toLowerCase().indexOf('chrome') >= 0
    $('input[autocomplete="off"]').each ->
      type = $(this).attr('type')
      if type[0] == '_'
        type = type.substr(1)
      $(this).attr 'type', '_' + type
      $(this).attr 'type', type



# project access step
$("body").on "change", "input", ->
  $input = $(this)
  name = $input.attr("name")
  input_type = $input.attr("type") || 'text'
  string_input_types = "url password text".split(" ")
  if string_input_types.indexOf(input_type) >= 0
    wizard[name] = $input.val()
  else if input_type == 'radio'
    wizard[name] = $("input[name='#{name}']:checked").val()
  else if input_type == 'checkbox'
    wizard[name] = $("input[name='"+name+"']:checked").map( ()->
      return $(this).val()
    )



$("body").on "click", ".checkout-button", ->
  $button = $(this)


$("body").on "focus", ".wizard-step:not(.touched)", ()->
  $(this).addClass("touched")


$("body").on "change", "[name=product_type]", ()->
  $(".rf-configure-button").removeAttr("disabled")

$("body").on "change code-change keyup", ".platforms .option-count", ()->
  price = getTotalPrice()
  if price > 0
    $("steps-progress .step").eq(0).addClass("proceeded")
  else
    $("steps-progress .step").eq(0).removeClass("proceeded")










showStepProgress = ()->
  $rf_input = $(this)
  $step = $rf_input.closest(".wizard-step")
  step_number = $step.attr("step-number")
  $form = $rf_input.closest("form")
  $form.validateForm()
  $invalid_inputs = $form.find(".rf-input.invalid")
  if !$invalid_inputs.length
    $("steps-progress .step").eq(2).addClass("proceeded")
  else
    $("steps-progress .step").eq(2).removeClass("proceeded")


$("body").on "change code-change keyup", ".wizard-step[step-number=2] .rf-input", showStepProgress
$("body").on "change code-change keyup", ".wizard-step[step-number=2] .rf-input", showStepProgress
$("body").on "change code-change keyup", ".wizard-step[step-number=3] .rf-input", showStepProgress