class UserPagesController < ApplicationController
  def registrations__new
    render "user_pages/static_sign_up"
  end

  def registrations__create
    @user = User.new
    @user.update_attributes(params[:user])
    if @user.save
      render "user_pages/show.json"
    else
      render "user_pages/show.json", status: 422
    end

    #render "user_pages/static_sign_up"
  end
end