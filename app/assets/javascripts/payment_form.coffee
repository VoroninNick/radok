window.form_types ?= {}
window.form_types['payment'] = {
  validateForm : ()->
    $form = $(this)
    payment_type = $(".payment-type.active").attr("value")
    #selector = ".rf-input"
    if payment_type == 'pay_later'
      selector = ".show-if-pay-later .rf-input"
      another_selector =  ".show-if-not-pay-later .rf-input"
    else
      selector = ".show-if-not-pay-later .rf-input"
      another_selector = ".show-if-pay-later .rf-input"

    $form.find(another_selector).removeClass("invalid")
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

    data
}

window.form_types['pay_later'] = {
  url : ()->
    $("form[for=project]").attr("url") + "/" + project.id + "/pay-later"
}

$("body").on "click", ".payment-form .payment-type", ()->
  $active_payment_type = $(".payment-form .payment-type.active")
  $active_payment_type.removeClass("active")
  $payment_type = $(this)

  $payment_type.addClass("active")

  pay_later = $payment_type.hasClass("pay-later")

  paypal = $payment_type.attr("value") == 'paypal'

  if pay_later
    $(".show-if-pay-later").removeClass("hide").show()
    $(".show-if-not-pay-later").hide()
  else
    $(".show-if-pay-later").hide()
    $(".show-if-not-pay-later").show()



  if paypal
    $(".show-if-paypal").show()
    $(".show-if-not-paypal").hide()
  else
    $(".show-if-paypal").hide()
    $(".show-if-not-paypal").show()


$("body").on "show_success", ".payment-form, .pay-later-form", ()->
  $form = $(this)
  $countdown = $form.find(".seconds-countdown")
  ms = parseInt($countdown.text()) * 1000
  setInterval(
    ()->
      val = parseInt($countdown.text())
      $countdown.text(val - 1)
    1000
  )

  if $form.hasClass("pay-later-form")
    redirect_location = "/dashboard/project/#{project.id}"
  else
    redirect_location = "/dashboard"

  setTimeout(
    ()->
      window.location = redirect_location
    ms
  )

