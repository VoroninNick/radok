class WizardMailer < ApplicationMailer


  def payment_request_admin_notification(payment, paid_test)

    to = FormConfigs::PaymentRequest.first.try(&:emails) || FormConfigs::PaymentRequest.default_emails
    @resource = payment
    @test = paid_test
    mail(
        template_path: "mailers/wizard",
        template_name: "payment_request_admin_notification",
        layout: false,
        to: to,
        subject: "New Payment Request"
    )
  end

  def pay_later_request_admin_notification(req)

    to = FormConfigs::PaymentRequest.first.try(&:emails) || FormConfigs::PaymentRequest.default_emails
    @resource = req
    @test = @resource.test
    mail(
        #template_path: "views/mailers/faq_request",
        template_path: "mailers/wizard",
        template_name: "pay_later_request_admin_notification",
        layout: false,
        to: to,
        subject: "New Pay Later Request"
    )
  end


end
