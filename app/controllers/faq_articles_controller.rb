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
    #@article = @faq_articles.published.first
    article_url_fragment = FaqArticle.published.pluck(:url_fragment).first
    #render "index"
    redirect_to faq_article_path(id: article_url_fragment), status: 302
  end

  def show
    init_articles
    #@article = @faq_articles.select{|a| a[:id] == params[:id].to_i}.first || @faq_articles.first
    @article = @faq_articles.where(url_fragment: params[:id]).first
    set_page_metadata(@article)
    @banner = Pages::FaqIndex.first.try(&:banner)

    render "index"
  end

  def init_articles
    #@faq_articles = FaqArticle.published.pluck(:id, :name, :content).map{|arr| {id: arr[0], name: arr[1], content: arr[2]} }
    @faq_articles = FaqArticle.published
  end

  def request_question
    if request.post?
      @faq_request = FaqRequest.create!(params[:faq_request])
      FaqRequestMailer.new_request(@faq_request).deliver
      render json: { result: "successfully rendered", code: 200 }
    else
      render json: { result: "error", code: 500 }
    end
  end
end
