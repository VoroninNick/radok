class ContactController < ApplicationController
  def contact_request
    if request.post?
      ContactRequest.create!(params[:contact_request])
      render json: { result: "successfully rendered", code: 200 }
    else
      render json: { result: "error", code: 500 }
    end
  end
end
