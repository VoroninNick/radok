$wizard_controller = $("#wizard-controller")
window.wizard = {}
wizard.price_per_hour = 20
wizard.hours_count = 1
active_step_number = 1

created = false
saving_in_progress = false

saveTest = ()->
  if !saving_in_progress
    if !created
      data = {test: $(".intro-step form").serializeHash()}
      saving_in_progress = true
      $.ajax(
        url: "/wizard"
        type: "post"
        dataType: "json"
        data: data
        complete: ->
          saving_in_progress = false
        success: (data)->
          $.extend(wizard, data)
          created = true
          window.history.pushState({}, "", "/wizard/#{data.id}")
      )



    else
      data = { test: {platforms: serializePlatforms(), hours_count: wizard.hours_count}}
      saving_in_progress = true
      $.ajax(
        url: "/wizard/#{wizard.id}"
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


scrollToStep = (step_number)->
  $step = $(".wizard-step[step-number=#{step_number}]")
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
  if valid
    $rf_next_step_button.removeAttr("disabled")
  else
    $rf_next_step_button.attr("disabled", "disabled")
editStep = (step_number)->


  $active_step = $(".wizard-step.active")
  $active_step.removeClass("active")
  $active_step.addClass("proceeded")
  $active_wizard_step_wrap = $active_step
  $requested_step = $(".wizard-step[step-number=#{step_number}]")
  $requested_step.addClass("active")
  $requested_step.validateStep()
  scrollToStep(step_number)
  valid = $requested_step.find(".rf-input.invalid").length == 0
  if !valid
    $(".rf-next-step-button").attr("disabled", "disabled")


  active_step_number = step_number
nextStep = ()->
  editStep(active_step_number + 1)
  saveTest()
$("#wizard-full-summary").addClass("hide")

$(".rf-next-step-button").on "click", ->
  nextStep()

$("body").on "click", ".wizard-step-edit-tooltip, .wizard-step-counter", ->
  $edit_tooltip = $(this)
  $wizard_step = $edit_tooltip.closest(".wizard-step")
  requested_step_number = parseInt($wizard_step.attr("step-number"))
  editStep(requested_step_number)

$(".rf-configure-button").on "click", ->
  saveTest()
  $wizard_controller.addClass("configure-mode")
  $(".intro-step").removeClass("active").addClass("proceeded")
  $("[data-bind=tot__type_of_test]").each ->
    $this = $(this)
    val = $("input[name=test_type]:checked").attr("data-name")
    $this.text(val)

  $("[data-bind=top__type_of_product]").each ->
    $this = $(this)
    val = $("input[name=product_type]:checked").attr("data-name")
    $this.text(val)

  $summary_footer =  $("#wizard-summary .footer")
  $summary_footer.removeClass("hide")

  $(".configuration-steps").removeClass("hide")

  $(".wizard-platforms-step").addClass("active")

  window.product_type_id = parseInt($('question[question-key=type_of_product] input:checked').attr('data-id'))

  #$(".wizard-platforms-step").find("platform").each ->
  #  $platform = $(this)
  #  if !$platform.hasClass("in-group")

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

  scrollToStep(1)


$(".option-count").on "click", ".decrement, .increment", ->
  $btn = $(this)
  increment = $btn.hasClass("increment")
  decrement = !increment
  $input_wrap = $btn.closest(".input-wrap")
  $option_count = $input_wrap.closest(".option-count")
  $input = $input_wrap.find("input")
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
  console.log event.type
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



window.getTotalPrice = (hours)->
  #wizard.hours_count
  $platforms = $(".wizard-platforms-step platform:not(.hide)")
  total_price = $platforms.map((index, item)->
    getPlatformPrice.call(item)
  ).toArray().sum()

  return total_price

presentTotalPrice = ()->
  total_price = getTotalPrice()
  $summary_footer =  $("#wizard-summary .footer")

  $rf_next_button = $(".rf-next-step-button")

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
  $(".option-count input:blank").each ->
    $this = $(this)
    old_val = $this.val()
    if(old_val != 0)
      $this.trigger_val(0)

  $('input.tags-input').tagsInput();

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

$("body").on "change", ".upload-area input#test_case_files", ->
  input = this
  $input = $(input)
  $upload_area = $input.closest(".upload-area")

  $list = $(".test_case_files-list")



  window.test_case_files_list ?= []
  new_files_length = input.files.length
  new_files_saved_count = 0
  for file in input.files
    $list.append("<div class='file'>#{file.name}<span class='delete'></span></div>")
    f = {name: file.name}
    reader = new FileReader()
    reader.onload = ->
      #console.log "reader.load", arguments
      src = reader.result
      f.content = src
      test_case_files_list.push(f)
      new_files_saved_count = new_files_saved_count + 1

      if new_files_length == new_files_saved_count
        $input.val(null)

    reader.readAsDataURL(file);


$("body").on "click", ".test_case_files-list .delete", ->
  $file = $(this).closest('.file')
  file_index = $file.index()
  $file.remove()
  window.test_case_files_list.splice(file_index, 1)


window.serializePlatforms = ()->
  platforms = []
  $('platform:not(.hide) .option-count input').each ->
    $input = $(this)
    count = parseInt($input.val())
    if count > 0
      platform_id = parseInt($input.closest(".option-count").attr("data-id"))
      platforms.push({id: platform_id, count: count})

  return platforms