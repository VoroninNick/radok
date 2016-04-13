$(document).on "ready", ()->
$change_password_form = $("#change-password-form")
$change_password_form.on "after_error", ()->
  console.log ("geronimo");

  $input = $change_password_form.find(".rf-input")
  $identical_error = $input.find(".error.identical")
  if $identical_error.length
    $identical_error.removeClass("hide")

  else
    $error = "<label for='user_password' class='error remote identical'>New password must be different from the current</label>"
    $input.prepend($error)

  $input.removeClass("valid").addClass("invalid")

  $input.find(".field-label").addClass("hide")


$change_password_form.on "after_success", ()->
  $input = $change_password_form.find(".rf-input")
  $input.addClass("valid").removeClass("invalid")
