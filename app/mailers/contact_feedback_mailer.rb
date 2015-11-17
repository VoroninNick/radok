class ContactFeedbackMailer < ApplicationMailer
  def new_request(request)
    to = FormConfigs::ContactFeedback.first.try(&:emails) || FormConfigs::ContactFeedback.default_emails
    @resource = request
    mail(
        #template_path: "views/mailers/faq_request",
        template_path: "mailers/faq_request",
        template_name: "faq_request",
        layout: false,
        to: to,
        subject: "New Contact feedback"
    )
  end

  def new_call(request)
    to = FormConfigs::ScheduleCall.first.try(&:emails) || FormConfigs::ScheduleCall.default_emails
    @resource = request
    mail(
        #template_path: "views/mailers/faq_request",
        template_path: "mailers/contact",
        template_name: "schedule_call",
        layout: false,
        to: to,
        subject: "New Schedule call request"
    )
  end
end
