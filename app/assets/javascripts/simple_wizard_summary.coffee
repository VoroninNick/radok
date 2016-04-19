init_wizard_summary_fixed = ()->
  $summary_fixed = $('#wizard-summary-fixed')
  scroll_top = $(window).scrollTop()
  $summary = $('#wizard-summary')
  summary_offset = $summary.offset()
  summary_fixed_abs_top = $summary_fixed.offset().top

  summary_top = if summary_offset then summary_offset.top else undefined
  fixed = scroll_top >= $('.page-banner').height()
  summary_height = $summary_fixed.height()
  summary_fixed_rel_top = parseInt($summary_fixed.css('top'))
  summary_fixed_rel_bottom = summary_fixed_rel_top + summary_height

  footer_top = $("#footer").offset().top
  window_height = $(window).height()
  footer_window_top = footer_top - (scroll_top)
  footer_in_screen = footer_window_top - window_height < 0
  min_indent_from_footer = 40

  if footer_in_screen
    diff = footer_window_top - ( summary_fixed_rel_bottom + min_indent_from_footer )
    transform_px = diff
  else
    transform_px = 0

  min_indent_from_header = 128
  min_scroll_top_for_transform = $("#header").height() + min_indent_from_header

  if transform_px == 0 && summary_fixed_rel_bottom > window_height && scroll_top >= min_scroll_top_for_transform
    transform_px = window_height - summary_fixed_rel_bottom

  if transform_px != 0
    $summary_fixed.css({transform: "translateY(#{transform_px}px)"})
    $summary_fixed.addClass("transform_px").removeClass("no_transform_px")
  else
    $summary_fixed.css({transform: ""})
    $summary_fixed.addClass("no_transform_px").removeClass("transform_px")

$(window).on('scroll', init_wizard_summary_fixed)
$(document).on('ready page:load', init_wizard_summary_fixed)
