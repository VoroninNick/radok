class Wizard::Test < ActiveRecord::Base
  attr_accessor :steps

  def initialize
   # Wizard::Step.available_steps
  end

  def self.available_steps
    step_classes = [Wizard::Steps::Intro, Wizard::Steps::Platforms, Wizard::Steps::ProjectInformation, Wizard::Steps::TestPlan, Wizard::Steps::ProjectAccess]
    data = {}
    step_classes.each do |step_class|
      data[step_class.name.underscore.split('/').last.to_sym] = step_class.available_options
    end

    data
  end

end

