class SitemapController < ApplicationController
  def index
    @content = Pages.sitemap_xml.try(:content)
    if @content.blank?
      @entries = Cms::SitemapElement.entries([:en])
    end
  end
end
