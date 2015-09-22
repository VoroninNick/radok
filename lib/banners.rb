module Banners
  module ClassMethods
    def has_banner
      has_one :banner, class_name: "Banner", autosave: true
      accepts_nested_attributes_for :banner
      attr_accessible :banner, :banner_attributes
    end
  end
end

ActiveRecord::Base.singleton_class.send(:include, Banners::ClassMethods)