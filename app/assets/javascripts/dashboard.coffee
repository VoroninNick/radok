duration = 1200
$.fn.animate_number = (options)->
  $this = $(this)
  local_duration = parseInt($this.attr("duration") ) || duration
  value = parseInt($this.attr('value'))
  $this.animateNumber({
    number: value
  }, local_duration,
    ->
      $this.addClass("completed")
      $this.closest("[animate-progress]").addClass("completed")
      #$this.text(value)
  )

$.fn.animate_circle_progress = ()->
  $(this).each ->
    $this = $(this)
    value = parseInt($this.attr('value')) / 100
    $this.circleProgress({
      startAngle: -Math.PI / 4 * 3,
      value: value,
      lineCap: 'round',
      fill: { color: '#ffa500' }
      size: 150
      thickness: 5
      animation: {
        duration: duration
      }
    });



check_and_animate_number = ->
  $("[animate-number]:not(.completed)").each ->
    $this = $(this)
    if !$this.hasClass("in-progress")
      top = $(window).scrollTop()
      bottom = top + window.innerHeight
      offset_top = $(this).offset().top
      if offset_top >= top && offset_top <= bottom
        $this.addClass("in-progress")
        $this.animate_number()


check_and_animate_progress = ->
  $("[animate-progress]").each ->
    completed = $(this).hasClass("completed")
    in_progress = $(this).hasClass("in-progress")
    if !completed && !in_progress
      top = $(window).scrollTop()
      bottom = top + window.innerHeight
      offset_top = $(this).offset().top
      if offset_top >= top && offset_top <= bottom
        $(this).addClass("in-progress")
        $(this).find("[animate-progress-number]").animate_number()
        $(this).find("[animate-progress-round]").animate_circle_progress()


check_and_animate_progress()
$(window).on "scroll", check_and_animate_progress

check_and_animate_number()
$(window).on "scroll", check_and_animate_number



$("[collapsable]").on "click", "[expander]", ->
  $expander = $(this)
  $collapsable = $expander.closest("[collapsable]")
  $collapsable.toggleClass("expanded")
  $content = $collapsable.find("[collapsable-content]")
  $content.slideToggle()

$("[parallax-banner]").each ->
  parallax = new Parallax(this)

$("#home-feedbacks .owl-carousel").owlCarousel(
  navigation : false
  singleItem : true
  navigationText: ["", ""]
  autoPlay: 15000
  stopOnHover: true
)

$("#home-feedbacks").on "click", ".rn-carousel-control-item", ->
  carousel = $("#home-feedbacks .owl-carousel").data("owlCarousel")
  if $(this).hasClass("rn-carousel-control-prev")
    carousel.prev()
  else
    carousel.next()

$map = $("#contact-map map")
#markers = $.map( $map.find("marker"), (item, index)->
#  $this = $(item)
#  console.log "marker", $this.get(0)
#  position = $this.attr("position")
#  lat = position.split(";")[0]
#  lon = position.split(";")[1]
#  title = $this.attr("title")
#  zoom = $this.attr("zoom") || 8
#  return { lat: $this.attr(""), lon: lon, title: title, zoom: zoom }
#)
#new Maplace({
#  locations: markers
#  controls_type: "list"
#  controls_on_map: false
#  generate_controls: false
#}).Load()

initialize_google_map = ->
  lat = 49.829182
  lng = 24.01275
  latlng = new google.maps.LatLng(lat, lng)

  mapOptions =
    zoom: 17
    center: latlng
    scrollwheel: true


  map = new google.maps.Map($map.get(0), mapOptions)

initialize_google_map()