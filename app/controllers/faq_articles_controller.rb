class FaqArticlesController < ApplicationController
  def articles
    articles = FaqArticle.published.pluck(:name, :content)
    render json: articles
  end

  def item

  end

  def index
    init_articles
    #@article = @faq_articles.published.first
    article_url_fragment = FaqArticle.published.pluck(:url_fragment).first
    #render "index"
    redirect_to action: :show, status: 302, id: article_url_fragment
  end

  def show
    init_articles
    #@article = @faq_articles.select{|a| a[:id] == params[:id].to_i}.first || @faq_articles.first
    @article = @faq_articles.where(url_fragment: params[:id]).first
    set_page_metadata(@article)

    render "index"
  end

  def init_articles
    #@faq_articles = FaqArticle.published.pluck(:id, :name, :content).map{|arr| {id: arr[0], name: arr[1], content: arr[2]} }
    @faq_articles = FaqArticle.published
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
