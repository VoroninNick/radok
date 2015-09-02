module Wizard
  module Steps
    class ProjectInformation < Wizard::Step
      attr_accessor :project_name
      attr_accessor :project_version
      attr_accessor :project_languages
      attr_accessor :report_languages

      def self.available_options

      end
    end
  end
end