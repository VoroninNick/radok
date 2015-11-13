window.form_types ?= {}
window.form_types['payment'] = {
  validateForm : ()->
    $form = $(this)
    payment_type = $(".payment-type.active").attr("value")
    #selector = ".rf-input"
    if payment_type == 'pay_later'
      selector = ".show-if-pay-later .rf-input"
    else
      selector = ".show-if-not-pay-later .rf-input"

    $form.find(selector).each ->

      $rf_input = $(this)

      $rf_input.validateInput()
      $form

  url : ()->
    $("form[for=project]").attr("url") + "/" + project.id + "/payment"

  serialize : ()->
    $form = $(this)
    data = $form.serializeArray()
    payment_type = $(".payment-type.active").attr("value")
    data.push({payment_type: payment_type})
}

$("body").on "click", ".payment-form .payment-type", ()->
  $active_payment_type = $(".payment-form .payment-type.active")
  $active_payment_type.removeClass("active")
  $payment_type = $(this)

  $payment_type.addClass("active")

  pay_later = $payment_type.hasClass("pay-later")
  if pay_later
    $(".show-if-pay-later").removeClass("hide").show()
    $(".show-if-not-pay-later").hide()
  else
    $(".show-if-pay-later").hide()
    $(".show-if-not-pay-later").show()