class ImageRadioButtonsInput < SimpleForm::Inputs::CollectionRadioButtonsInput
  include ActionView::Helpers::AssetTagHelper
  def input
    input_name = @reflection_or_attribute_name || @reflection.name
    raw ("<div class='options'>" +
    @builder.collection_radio_buttons(input_name, @options[:collection], :id, :name) do |b|

      b.radio_button() +
      b.label() do
        image_tag(b.object.image.url)
      end +
      b.label(text: b.object.name)
    end + "</div>")
  end
end