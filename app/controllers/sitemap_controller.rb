class SitemapController < ApplicationController
  def index
    @entries = Cms::SitemapElement.entries([:en])
  end
end