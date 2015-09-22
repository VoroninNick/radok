module Devise
  module Models
    module Validatable


      def self.included(base)

        base.class_eval do
          #....SNIP...
          validates_confirmation_of :password, :if => :password_required?
        end
      end

      #...SNIP...

      def password_required?
        !persisted? || !password.nil? || !password_confirmation.nil?
      end
    end
  end
end
