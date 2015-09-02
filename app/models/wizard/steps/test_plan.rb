module Wizard
  module Steps
    class TestPlan < Wizard::Step
      attr_accessor :type_of_test

      def self.available_options
        {
          type_of_test: {

          }
        }
      end
    end
  end
end