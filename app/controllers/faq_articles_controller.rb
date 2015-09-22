class FaqArticlesController < ApplicationController
  def articles
    articles = FaqArticle.published.pluck(:name, :content)
    render json: articles
  end

  def item

  end

  def index
    init_articles
    @article = @faq_articles.first
    render "index"
  end

  def show
    init_articles
    @article = @faq_articles.select{|a| a[:id] == params[:id].to_i}.first || @faq_articles.first
    render "index"
  end

  def init_articles
    @faq_articles = FaqArticle.published.pluck(:id, :name, :content).map{|arr| {id: arr[0], name: arr[1], content: arr[2]} }
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
