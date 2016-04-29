class FaqArticlesController < ApplicationController
  before_action :set_page_banner, only: [:index, :show]

  def index
    init_articles
    article_url_fragment = FaqArticle.published.pluck(:url_fragment).first
    redirect_to faq_article_path(id: article_url_fragment), status: 302
  end

  def show
    init_articles
    @article = @faq_articles.where(url_fragment: params[:id]).first
    set_page_metadata(@article)
    render 'index'
  end

  def init_articles
    @faq_articles = FaqArticle.published
  end

  def request_question
    if request.post?
      @faq_request = FaqRequest.create!(params[:faq_request])
      FaqRequestMailer.new_request(@faq_request).deliver
      render json: { result: 'successfully rendered', code: 200 }
    else
      render json: { result: 'error', code: 500 }
    end
  end

  def set_page_banner
    banner_url = Rails.root.join('fixtures', 'images', 'radok-web-banner-FAQ.png')
    @banner = Banner.new(title: 'FAQ', description: 'Get an answer to what You may not know')
    @banner.attach_background_image(banner_url)
    super
  end
end
