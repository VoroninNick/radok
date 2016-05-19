$(".bug-list-table-wrap").on "click", "tr", ()->
  url = $(this).attr("url")
  window.location = url


$(".attachments-panel .attachments").lightGallery({
  #zoom: false
  #fullScreen: false
  #autoplay: false
  #autoplayControls: false
  #download: false
})

$(".new-comment-form textarea").on "change keyup", ()->
  $textarea = $(this)
  empty = $textarea.val().length == 0
  $button = $("#post-comment-button")
  if empty
    $button.attr("disabled", "true")
  else
    $button.removeAttr("disabled")
