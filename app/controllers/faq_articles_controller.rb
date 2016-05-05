# == Schema Information
#
# Table name: faq_articles
#
#  id           :integer          not null, primary key
#  published    :boolean
#  name         :string
#  content      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  url_fragment :string
#

class FaqArticlesController < ApplicationController
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
end
