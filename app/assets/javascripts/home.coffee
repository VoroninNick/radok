###
$(document).on "ready", ()->
  $counters = $("#home-statistics .counter")
  $counters.each ()->
    $counter = $(this)
    $counter.css({width: $counter.outerWidth()})
  $counters.counterUp({
    #delay: 2000,
    time: 2000
  })
###