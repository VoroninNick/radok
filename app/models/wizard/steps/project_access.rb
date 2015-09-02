module Wizard
  module Steps
    class ProjectAccess < Wizard::Step
      attr_accessor :type_of_test
      attr_accessor :project_auth
      attr_accessor :comment

      def self.available_options

      end
    end
  end
end