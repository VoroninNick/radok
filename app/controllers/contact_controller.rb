class ContactController < ApplicationController
  def contact_feedback
    if request.post?
      @contact_feedback = ContactFeedback.create!(params[:contact_feedback])
      ContactFeedbackMailer.new_request(@contact_feedback).deliver
      render json: { result: "successfully rendered", code: 200 }
    else
      render json: { result: "error", code: 500 }
    end
  end

  def schedule_call
    render json: {}, status: 201
  end
end
