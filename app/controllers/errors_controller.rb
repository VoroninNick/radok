class ErrorsController < ApplicationController
  def not_found
    render status: 404, layout: "not_found"
  end
end