class Test
  @test_type = null
  @product_type = null
  @steps_proceeded = null
  @total_steps = null
  @current_step_number = null

  set_test_type = (value)->
    @test_type = value





window.current_test = null


init_wizard_summary_fixed = ()->
  $summary_fixed = $('#wizard-summary-fixed')
  scroll_top = $(window).scrollTop()
  $summary = $('#wizard-summary')
  summary_offset = $summary.offset()
  summary_top = if summary_offset then summary_offset.top else undefined
  #fixed = scroll_top >= summary_top
  #fixed = scroll_top >= $('#header').height() + $('#wizard-banner').height()
  fixed = scroll_top >= $('.page-banner').height()
  summary_height = $summary_fixed.height()

  console.log(fixed)
  if fixed
    $summary_fixed.addClass("fixed-top")

  else
    $summary_fixed.removeClass("fixed-top")


  diff = $("#footer").offset().top - ( summary_top + summary_height )
  transform_px = diff
  console.log "diff: ", diff
  if transform_px != 0
    $summary_fixed.css({transform: "translateY(#{transform_px}px)"})
    $summary_fixed.addClass("transform_px").removeClass("no_transform_px")
  else
    $summary_fixed.css({transform: ""})
    $summary_fixed.addClass("no_transform_px").removeClass("transform_px")


$(window).on('scroll', init_wizard_summary_fixed)
$(document).on('ready page:load', init_wizard_summary_fixed)

init_number_options = ()->
  $('.option-count').each (index, item)->
    $option = $(this)
    $input = $option.find('input[type=number]')
    $input.wrap("<div class='input-wrap'>")
    $input_wrap = $input.parent()
    $input.attr({"pattern": "[0-9]*", type: "text"})




#$(document).on "keyup"
$(document).on "focusin focusout", ".option-count .input-wrap", (e)->
  $option_count = $(this).closest('.option-count')
  focused = e.type == "focusin"
  if focused
    $option_count.addClass('focus')
  else
    $option_count.removeClass('focus')

  console.log("event: ", e)

$.fn.check_whether_step_ready_to_proceed = ()->
  $step = $(this)
  ready = true
  $required_inputs = $step.find('.input.required')
  $required_inputs.each ()->
    $input = $(this)
    if !$input.find('input').filter(':checked').length
      ready = false
  return ready

$.fn.get_future_steps = ()->
  $step = $(this).closest('.wizard-step')
  return $step.nextAll()

$.fn.go_to_this_step = ()->
  $steps = $(".configuration-steps .wizard-step")
  $required_step = $(this).closest(".wizard-step")
  $active_step = $steps.filter(".active")
  if $required_step.length > 0 && (!$required_step.hasClass('unavailable') || $active_step.hasClass("ready-to-proceed") ) && !$required_step.hasClass('active')

    active_step_index = $active_step.index()
    required_step_index = $required_step.index()
    step_difference = required_step_index - active_step_index
    required_future = step_difference > 0
    required_completed = !required_future
    required_next = step_difference == 1
    required_prev = step_difference == -1
    $active_step.removeClass("active ready-to-proceed")
    $required_step.removeClass("unavailable")
    if required_future
      $active_step.addClass("completed")
      if required_next
        $active_step.addClass("prev")
    else # required completed
      $active_step.addClass("future")


    if $required_step.hasClass("completed")
      $required_step.addClass("review")

    if required_next && !$required_step.hasClass("completed")
      $active_step.trigger("completed")

    required_step_top = $required_step.offset().top
    required_step_top = $('.intro-step').offset().top + $('.intro-step').height()
    top_to_animate = required_step_top - $('#header').height() - 48
    #alert(top_to_animate)



    $('#body').animate({scrollTop: top_to_animate})



    $required_step.removeClass("future").addClass("active")
    ready = $required_step.check_whether_step_ready_to_proceed()
    if ready
      $required_step.addClass("ready-to-proceed")

wizard_summary_set_steps_completed = (step_number)->
  $summary = $("#wizard-summary")
  total = + $summary.find(".total-steps").text()
  width_ratio = (step_number / total * 100)
  percentage_width = width_ratio + "%"
  $progress_line = $summary.find(".progress-line")
  $progress_line.css({width: percentage_width})
  $completed_step_number = $('.completed-step-number')
  $completed_step_number.text(step_number)

  $completed_step_number.css({right: (100 - width_ratio) + "%" })

wizard_summary_set_test_type = (type)->
  $test_type = $("p.test-type-and-product-type span.test-type")
  $test_type_and_product_type = wizard_summary_get_test_type_and_product_type_container()

  if $test_type.length == 0
    $test_type = $("<span class='test-type'>")
    $test_type_and_product_type.prepend($test_type)

  $test_type.html("You ordered <span class='test name'>#{type}</span>&nbsp;")

wizard_summary_set_product_type = (type)->
  $product_type = $("p.test-type-and-product-type span.product-type")
  $test_type_and_product_type = wizard_summary_get_test_type_and_product_type_container()

  if $product_type.length == 0
    $product_type = $("<span class='product-type'>")
    $test_type_and_product_type.append($product_type)

  $product_type.html("for <span class='name'>#{type}</span>")





wizard_summary_get_test_type_and_product_type_container = ()->
  $test_type_and_product_type = $("p.test-type-and-product-type")
  if $test_type_and_product_type.length == 0
    $test_type_and_product_type = $("<p class='test-type-and-product-type'>")
    $test_type_and_product_type.insertAfter("#wizard-summary-fixed .content .steps-completed")
  return $test_type_and_product_type

on_next_step = ()->
  $next_step = $(this).closest(".wizard-step").next()
  $next_step.go_to_this_step()

on_prev_step = ()->
  $(this).closest(".wizard-step").prev().go_to_this_step()
on_step_completed = ()->
  $step = $(this).closest(".wizard-step")
  step_index = $step.index()
  step_number = step_index + 1
  wizard_summary_set_steps_completed(step_number)
  if step_index == 0
    type_name = $step.find(".option-image-input:checked").find("~ label .name").text()
    wizard_summary_set_test_type(type_name)
  if step_index == 1
    type_name = $step.find(".option-image-input:checked").find("~ label .name").text()
    wizard_summary_set_product_type(type_name)






on_step_counter_click = ()->
  $step_counter = $(this)
  $step = $step_counter.closest(".wizard-step")
  $step.go_to_this_step()



on_value_changed = (event)->

  $step = $(this).closest(".wizard-step")
  if !$step.hasClass("active")
    $active_step = $(".wizard-step.active")
    $step.addClass("active")
  if $step.check_whether_step_ready_to_proceed()
    $step.next().addClass("ready-to-go-to-this-step")





init_steps = ()->
  $steps = $('.wizard-step')
  $first_step = $steps.first()
  $first_step.addClass('active')
  if $first_step.check_whether_step_ready_to_proceed()
    $first_step.addClass('ready-to-proceed')
  else
    $next_steps = $first_step.nextAll()
    #$next_steps.addClass("unavailable")
  $first_step.get_future_steps().addClass('future')

  $steps_container = $('#wizard-steps')
  $steps_container.on "change", "input", ()->
    $step = $(this).closest('.wizard-step')
    ready = $step.check_whether_step_ready_to_proceed()
    if ready
      $step.addClass("ready-to-proceed")

init_test = ()->
  if !current_test
    window.current_test = new Test
    current_test.total_steps = $(".wizard-step").length
    current_test.steps_proceeded = 0
    current_test.current_step_number = 1

available_char_codes = [[37,40], [48, 57], 46]
_available_char_codes = []
for c in available_char_codes
  if Array.isArray(c)
    for cc in [c[0]...c[1]+1]
      _available_char_codes.push(cc)
  else
    _available_char_codes.push(c)
window.available_char_codes = _available_char_codes


###
$(document).on "keypress", "input", (e)->

  return if $(this).closest(".tagsinput").length > 0
  #alert(e.which)
  for c in available_char_codes
    console.log("#{c}")

  if window.available_char_codes.indexOf(e.which) < 0
    console.log("preventDefault: which: #{e.which}")
    e.preventDefault()

###



window.mouse_is_down = false
counter_interval = null
$counter_input = null

change_counter_value = ()->

###
$(document).on "mousedown", "div.option-count label, div.option-count input", (e)->
  $label = $(this)
  window.mouse_is_down = true
  $input_wrap = $label.closest(".input-wrap")
  $input = $input_wrap.find("input")
  $input.addClass("focus")

  increment = 1
  decrement = 1
  input_value = parseInt($input.val())

  if counter_interval == null
    if $label.hasClass("increment")
      $counter_input = $input
      counter_interval = setInterval( ()->
        if window.mouse_is_down
          $counter_input.val(parseInt($counter_input.val()) + 1)
      , 200)
    else if $label.hasClass("decrement")
      $counter_input = $input
      counter_interval = setInterval( ()->
        if window.mouse_is_down
          $counter_input.val(parseInt($counter_input.val()) - 1)
      , 200)
###

###
$(document).on "click", "*", (e)->
#  window.mouse_is_down = false
#  clearInterval(counter_interval)
#  counter_interval = null

  $this = $(this)
  $option_count = $this.closest('.option-count')
  if $option_count.length == 0
    $option_count = $('.option-count input.focus')
    console.log("hello", $option_count.length) if $option_count.length > 0
    $option_count.removeClass("focus")
###

$(document).on "page:load ready", ()->
  if $("#wizard-controller").length > 0
    init_test()
    init_number_options()
    init_steps()


    ###$(".selectize-tags-input input").selectize
      delimiter: ',',
      persist: false,
      create: (input)->
        return {
          value: input,
          text: input
        }
    ###

    #$(".selectize-tags-input input").tagsInput()



    $wizard_steps_container = $('#wizard-steps')
    $wizard_steps_container.on "click", ".go-next-button", on_next_step
    $wizard_steps_container.on "click", ".go-back", on_prev_step
    $wizard_steps_container.on "click", ".wizard-step-counter", on_step_counter_click
    $wizard_steps_container.on "click", ".wizard-step-counter", on_step_counter_click
    #$wizard_steps_container.on "completed", ".wizard-step", on_step_completed
    $wizard_steps_container.on "change", "input, textarea", on_value_changed

