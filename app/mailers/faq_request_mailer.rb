class FaqRequestMailer < ApplicationMailer
  def new_request(request)
    to = FormConfigs::FaqRequest.first.try(&:emails) || FormConfigs::FaqRequest.default_emails
    @resource = request
    mail(
        template_path: "mailers/faq_request",
        template_name: "faq_request",
        layout: false,
        to: to,
        subject: "New FAQ Request"
    )
  end
end
