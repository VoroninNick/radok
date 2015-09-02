class AboutController < ApplicationController
  def leaders
    leaders = Leader.all.map{|l| {image_path: l.image.url(:thumb), name: l.name, position: l.position} }
    render json: leaders
  end
end
