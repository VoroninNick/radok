class SitemapController < ApplicationController
  def index
    @entries = SitemapElement.entries([:en])
  end
end