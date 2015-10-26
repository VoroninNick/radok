module PagesHelper
  def html_block_with_fallback(key, from_page_instance = false, &block)
    page_instance = nil
    html_block = nil
    if from_page_instance == true
      page_instance = @page_instance
    elsif from_page_instance.is_a?(Page)
      page_instance = from_page_instance
    end

    page_instance.try do |p|
      html_block = p.html_blocks.by_field(key).first
    end

    if  (html_block || (html_block = KeyedHtmlBlock.by_key(key).first)) && html_block.content.present?
      return raw html_block.content
    end

    if block_given?
      yield
      #self.instance_eval(&block)

    end

    nil

  end
end