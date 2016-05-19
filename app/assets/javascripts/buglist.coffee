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