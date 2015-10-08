$("body").on "submit", "form.mail-form", (event)->

  $form = $(this)
  if $form.hasClass("submitted")
    $form.addClass("name-built")

    $form.validateForm()

    valid_form = $form.find(".rf-input.invalid").length == 0

    if valid_form && !$form.hasClass("name-built")
      $form.addClass("name-built")
      $login_input = $("input[name=login]")
      value = $login_input.val()
      hostname = $("html").attr("data-hostname")
      $login_input.val("#{value}@#{hostname}")
      $form.addClass("submitted")
      $form.submit()
    else
      event.preventDefault()
