signinWin = undefined

CheckLoginStatus = ->
  if signinWin.closed
    $('#UserInfo').text $.cookie('some_cookie')
  else
    setTimeout CheckLoginStatus, 1000
  return

$('body').on "click", ".facebook-login", (e)->
  e.preventDefault()
  url = $(this).attr("href")
  window_width = 780
  window_height = 410
  pos = get_center_coordinates(window_width, window_height)
  signinWin = window.open(url, 'SignIn', "width=#{window_width},height=#{window_height},toolbar=0,scrollbars=0,status=0,resizable=0,location=0,menuBar=0,left=#{pos.left},top=#{pos.top}")
  setTimeout CheckLoginStatus, 2000
  signinWin.focus()
  false

get_center_coordinates = (w, h)->
  dualScreenLeft = if window.screenLeft != undefined then window.screenLeft else screen.left
  dualScreenTop = if window.screenTop != undefined then window.screenTop else screen.top

  width = if window.innerWidth then window.innerWidth else if document.documentElement.clientWidth then document.documentElement.clientWidth else screen.width
  height = if window.innerHeight then window.innerHeight else if document.documentElement.clientHeight then document.documentElement.clientHeight else screen.height

  left = width / 2 - (w / 2) + dualScreenLeft
  top = height / 2 - (h / 2) + dualScreenTop

  return {top: top, left: left}


PopupCenter = (url, title, w, h) ->
  # Fixes dual-screen position                         Most browsers      Firefox
  dualScreenLeft = if window.screenLeft != undefined then window.screenLeft else screen.left
  dualScreenTop = if window.screenTop != undefined then window.screenTop else screen.top
  width = if window.innerWidth then window.innerWidth else if document.documentElement.clientWidth then document.documentElement.clientWidth else screen.width
  height = if window.innerHeight then window.innerHeight else if document.documentElement.clientHeight then document.documentElement.clientHeight else screen.height
  left = width / 2 - (w / 2) + dualScreenLeft
  top = height / 2 - (h / 2) + dualScreenTop
  newWindow = window.open(url, title, 'scrollbars=yes, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left)
  # Puts focus on the newWindow
  if window.focus
    newWindow.focus()
  return