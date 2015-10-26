class Pages::Home < Page

  has_html_block :how_it_works, :what_for_you, :statistics, :plans, :devices, :feedbacks, :bottom_block

  def self.default_url
    "/"
  end
end