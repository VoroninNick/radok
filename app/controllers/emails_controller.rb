class EmailsController < ApplicationController
  layout "users/mailer"

  before_action :set_variables, except: :index

  include EmailsHelper

  def set_variables
    #@email = "office@10g-force.com"
    #@phone = "+1-514-585-8198"
    @resource = User.last
  end

  def index
    render template: "emails/index", layout: false
  end

  def confirmation_instructions
    @token = "token"
    render template: "users/mailer/confirmation_instructions"
  end

  def reset_password_instructions
    render template: "users/mailer/reset_password_instructions"
  end

  def unlock_instructions
    render template: "users/mailer/unlock_instructions"
  end
end