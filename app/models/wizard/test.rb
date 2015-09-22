class Wizard::Test < ActiveRecord::Base
  attr_accessor :steps



  #def initialize
   # Wizard::Step.available_steps
  #end

  def self.available_steps
    step_classes = [Wizard::Steps::Intro, Wizard::Steps::Platforms, Wizard::Steps::ProjectInformation, Wizard::Steps::TestPlan, Wizard::Steps::ProjectAccess]
    data = {}
    step_classes.each do |step_class|
      data[step_class.name.underscore.split('/').last.to_sym] = step_class.available_options
    end

    data
  end

  def type_of_test_logo
    "rf-icon-functional-test"
  end

  def pi__project_name
    "Test Project #{self.id || "Name"}"
  end

  def project_name
    pi__project_name
  end

  def type_of_product
    "games"
  end

  def type_of_product_logo_path
    "rf-icon-test-type"
  end

  def type_of_test
    "test"
  end

  def testing_type
    "Explained"
  end

  def total_testers_count
    1
  end

  def ps__hours
    1
  end

  def percent_completed_counter
    16
  end

  def completed?
    true
  end

  def successful?
    false
  end

  def report_name
    "Bugfix report v2.56"
  end

  def version_number
    2.56
  end

  def product_type
    "games"
  end

  def project_languages
    [:english, :ukrainian, :russian]
  end

  def report_languages
    [:english, :ukrainian]
  end

  def project_access__url
    "http://voroninstudio.eu"
  end

  def platforms
    {
        ie: {testers_count: 53, logo_path: "ie", name: "Browsers", platform_subitems: [
            {name: "Internet Explorer 9", count: 1},
            {name: "Internet Explorer 10", count: 2}
        ]},
        ios: {testers_count: 3, logo_path: "ios", name: "IOS", platform_subitems: [
            {name: "Safary 3", count: 2}
        ]},
        android: { testers_count: 0, logo_path: "android", name: "Android" }}
  end

  def tot__type_of_test
    nil
  end

  def intro_step_proceeded?
    false
  end

  def instructions
    "hello"
  end

  def hours_per_tester
    rand(1..5)
  end

  def price
    rand(100..5000)
  end



end

