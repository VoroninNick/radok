class PagesController < ApplicationController
  before_action :set_page_metadata
  def self.actions
    self.instance_methods.sort - self.superclass.instance_methods - %w(default set_page_metadata).map(&:to_sym)
  end

  def default
    initial_template = params[:initial_template]
    if template_exists?(initial_template)
      render initial_template
    end
  end

  def pricing
    render "static_html/pricing"
  end

  def how_it_works
    render "static_html/how_it_works"
  end

  def testing_services
    render "static_html/testing_services"
  end

  def about
    render "static_html/about"
  end

  def set_page_metadata
    page_class = params[:page_class_name].try(&:constantize)
    @page_metadata = page_class.try(&:first).try(&:seo_tags)

    @page_metadata ||= { head_title: page_class.try(&:default_head_title) }

    #render inline: @page_metadata.inspect


  end
end