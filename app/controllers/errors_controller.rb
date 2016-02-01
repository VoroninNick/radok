class ErrorsController < ApplicationController
  def not_found
    set_page_metadata("not_found")

    path = Rails.root.join("public/404.html")
    if !File.exists?(path)
      render template: "errors/not_found.html.slim", status: 404, layout: "not_found"
      cache_page(nil, path)
    else
      render template: "errors/not_found.html.slim", status: 404, file: path, layout: false
    end

  end
end