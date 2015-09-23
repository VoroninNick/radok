$wizard_controller = $("#wizard-controller")
scrollToStep = (step_number)->
  $step = $("wizard-step[step-number=#{step_number}]")
  step_top = $step.offset().top
  top_for_scroll = step_top - 80
  $('body').animate(scrollTop: top_for_scroll)

$("#wizard-full-summary").addClass("hide")
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
  $input.val(new_value)
  if new_value > 0
    $option_count.removeClass("empty")
  else
    $option_count.addClass("empty")