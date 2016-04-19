$(document).on "ready", ()->
$change_password_form = $("#change-password-form")
$change_password_form.on "after_error", ()->

  $input = $change_password_form.find(".rf-input")
  $identical_error = $input.find(".error.identical")
  if $identical_error.length > 1
    $identical_error.removeClass("hide")

  else
    $error = "<label for='user_password' class='error remote identical'>New password must be different from the current</label>"
    $input.prepend($error)

  $input.removeClass("valid").addClass("invalid")

  $input.find(".field-label").addClass("hide")

$change_password_form.on "after_success", ()->
  $input = $change_password_form.find(".rf-input")
  $input.addClass("valid").removeClass("invalid")
<<<<<<< HEAD
=======
  $input.val("")
  $change_password_form.find(".form-content").removeClass("invisible").removeClass("hide")
>>>>>>> 169e00fc1524ddd3137d1619406ceb47ffdd905c
