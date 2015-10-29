$.fn.formify = (method)->
  form = null
  if method == undefined
    $form = $(this)
    form = new Formify.Form($form)
    form.render()

  else

  return form

