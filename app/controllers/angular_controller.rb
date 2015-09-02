class AngularController < ApplicationController
  def wizard
  end

  def index
    render template: "home/index"
  end
end
