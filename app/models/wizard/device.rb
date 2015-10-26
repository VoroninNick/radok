class Wizard::Device < ActiveRecord::Base
  attr_accessible *attribute_names

  belongs_to :manufacturer
  attr_accessible :manufacturer

  validates :manufacturer, :model, :os, :screen_pixel_width, :screen_pixel_height, presence: true

  def screen_pixel_size
    "#{screen_pixel_width}x#{screen_pixel_height}"
  end

  def object_label
    model
  end
end
