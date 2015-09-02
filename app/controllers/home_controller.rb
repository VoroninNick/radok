class HomeController < ApplicationController
  def index
    # @how_it_works_items = [
    #     {svg: "rf-mobile-apps", name: "Draft your test requirements", time: "2-5 minutes", description: "Fell in all needed requirements by our user-friendly wizard and go to step 2. It will take up to 5 minutes"},
    #     {svg: "rf-mobile-apps", name: "Draft your test requirements", time: "2-5 minutes", description: "Fell in all needed requirements by our user-friendly wizard and go to step 2. It will take up to 5 minutes"},
    #     {svg: "rf-mobile-apps", name: "Draft your test requirements", time: "2-5 minutes", description: "Fell in all needed requirements by our user-friendly wizard and go to step 2. It will take up to 5 minutes"}
    # ]

    #render file: Rails.root.join("app/assets/templates/home.html"), layout: false

    #@title = "Home page"

    #@template = "/assets/home.html"

    render template: "layouts/ng", layout: false
  end

  def about
    @template = "/assets/about.html"

    @title = "About us page"

    render template: "layouts/ng", layout: false
  end

  def contact
    @template = "/assets/contact.html"

    @title = "Contact us page"

    render template: "layouts/ng", layout: false
  end


  def svg_images
    file_paths = Dir[Rails.root.join("app/assets/images/*.svg")]
    file_data = file_paths.map do |file_path|
      comp = File.basename(file_path)
      extn = File.extname(file_path)
      name = File.basename(file_path, extn)

      file_content = File.read(file_path)
      doc = Nokogiri::HTML::DocumentFragment.parse file_content
      res = res = doc.to_html

      compressor = HtmlCompressor::Compressor.new
      compressed = compressor.compress(res)
      compressed_without_xml_dtd = compressed.sub(/<\?xml.*\?>/, '')



      {content: compressed_without_xml_dtd, file_path: name}
    end

    render inline: file_data.to_json

  end
end
