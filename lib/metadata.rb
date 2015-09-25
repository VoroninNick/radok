module Metadata
  module ClassMethods
    def has_seo_tags
      has_one :seo_tags, class_name: MetaData, autosave: true, dependent: :destroy, as: :page
      accepts_nested_attributes_for :seo_tags
      attr_accessible :seo_tags, :seo_tags_attributes
    end

    def respond_to_seo_tags?
      self._reflections['seo_tags'].present?
    end
  end

  module InstanceMethods
    def has_seo_tags?
      self.class.respond_to_seo_tags? && self.seo_tags.present?
    end
  end
end

ActiveRecord::Base.singleton_class.send(:include, Metadata::ClassMethods)

ActiveRecord::Base.send(:include, Metadata::InstanceMethods)