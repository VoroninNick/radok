module Wizard
  module Steps
    class Intro < Wizard::Step
      attr_accessor :type_of_test
      attr_accessor :type_of_product

      def self.available_options

      end
    end
  end
end