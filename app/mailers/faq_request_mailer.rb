class FaqRequestMailer < ApplicationMailer
  def new_request(request)
    to = FormConfigs::FaqRequest.first.try(&:emails) || FormConfigs::FaqRequest.default_emails
    @faq_request = request
    mail(
        #template_path: "views/mailers/faq_request",
        template_path: "mailers/faq_request",
        template_name: "faq_request",
        layout: false,
        to: to,
        subject: "New FAQ Request",
        from: "Radok force"
    )
  end
end
