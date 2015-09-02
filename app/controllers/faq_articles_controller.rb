class FaqArticlesController < ApplicationController
  def articles
    articles = FaqArticle.published.pluck(:name, :content)
    render json: articles
  end

  def item

  end

  def request_question
    if request.post?
      FaqRequest.create!(params[:request_question])
      render json: { result: "successfully rendered", code: 200 }
    else
      render json: { result: "error", code: 500 }
    end
  end
end
