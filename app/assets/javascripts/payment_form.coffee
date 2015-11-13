$("body").on "click", ".payment-form .payment-type", ()->
  $active_payment_type = $(".payment-form .payment-type.active")
  $active_payment_type.removeClass("active")
  $payment_type = $(this)

  $payment_type.addClass("active")