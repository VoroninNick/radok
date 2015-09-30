class Wizard::Test < ActiveRecord::Base
  attr_accessor :steps

  attr_accessible *attribute_names

  has_attachments :test_case_files

  has_attachments :test_files

  has_many :test_platforms_bindings, class_name: Wizard::TestPlatform#, foreign_key: [:test_id, :platform_id]
  has_many :platforms, class_name: Wizard::Platform, through: :test_platforms_bindings


  accepts_nested_attributes_for :test_platforms_bindings
  attr_accessible :test_platforms_bindings, :test_platforms_bindings_attributes

  attr_accessible :testers_by_platform

  def testers_by_platform=(platforms)
    puts "testers_by_platform="
    puts platforms.inspect
    platforms.each do |k , p|
      platform_id = p['id'].to_i
      count = p['count'].to_i
      test_platform_binding = Wizard::TestPlatform.where(platform_id: platform_id, test_id: self.id).first
      if test_platform_binding.nil?
        test_platform_binding = Wizard::TestPlatform.new(test_id: self.id, platform_id: platform_id, testers_count: count)

        test_platform_binding.save

      elsif test_platform_binding.testers_count != count
        #test_platform_binding.testers_count = count
        test_platform_binding.update(testers_count: 5)
      end




    end
    platform_ids = platforms.map{|k, p| p['id'].to_i }
    platforms_to_remove = Wizard::TestPlatform.where(test_id: self.id).where.not(platform_id: platform_ids)
    platforms_to_remove.delete_all
  end

  def has_platform_by_id?(platform_id)
    self.test_platforms_bindings.where(platform_id: platform_id).any?
  end

  def platform_testers_count(platform_id)
    self.test_platforms_bindings.where(platform_id: platform_id).first.try(&:testers_count)
  end

  #def initialize
   # Wizard::Step.available_steps
  #end

  def available_platforms

  end

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

