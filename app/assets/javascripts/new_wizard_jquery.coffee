$wizard_controller = $("#wizard-controller")
wizard = {}
wizard.price_per_hour = 20
wizard.hours_count = 1
active_step_number = 1






scrollToStep = (step_number)->
  $step = $("wizard-step[step-number=#{step_number}]")
  step_top = $step.offset().top
  top_for_scroll = step_top - 80
  $('body').animate(scrollTop: top_for_scroll)

$("#wizard-full-summary").addClass("hide")

$(".rf-next-step-button").on "click", ->
  scrollToStep(active_step_number + 1)

$(".rf-configure-button").on "click", ->
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

  $(".wizard-platforms-step .wizard-step").addClass("active")

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
  $platforms_step = $(this).closest("wizard-step.wizard-platforms-step")
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

#$("body").on "check uncheck", "input", (event)->
#  console.log "event: ", event

#$("body").on "change code-change", "input", (event)->
#  console.log event.type
#
#
#  $('button').on "click", ->
#    $(document).trigger("ready")
