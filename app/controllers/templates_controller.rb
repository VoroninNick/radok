class TemplatesController < ApplicationController
  def index

  end

  def html_to_slim
    html = params["html"]
    slim = HTML2Slim.convert!(html).to_s

    return render json: { slim: slim }
  end
end