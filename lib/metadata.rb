module Metadata
  module ClassMethods
    def has_seo_tags
      has_one :seo_tags, class_name: MetaData, autosave: true, dependent: :destroy
      accepts_nested_attributes_for :seo_tags
      attr_accessible :seo_tags, :seo_tags_attributes
    end
  end
end

ActiveRecord::Base.singleton_class.send(:include, Metadata::ClassMethods)