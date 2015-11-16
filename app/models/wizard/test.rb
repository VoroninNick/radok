class Wizard::Test < ActiveRecord::Base
  attr_accessor :steps

  attr_accessible *attribute_names

  has_attachments :test_case_files

  has_attachments :test_files

  has_many :test_platforms_bindings, class_name: Wizard::TestPlatform#, foreign_key: [:test_id, :platform_id]
  has_many :platforms, class_name: Wizard::Platform, through: :test_platforms_bindings

  belongs_to :user, class_name: User

  belongs_to :product_type, class_name: Wizard::ProductType
  belongs_to :test_type, class_name: Wizard::TestType




  has_and_belongs_to_many :project_languages, class_name: Wizard::ProjectLanguage, join_table: :wizard_test_project_languages
  has_and_belongs_to_many :report_languages, class_name: Wizard::ReportLanguage, join_table: :wizard_test_report_languages

  has_many :payment_requests

  attr_accessible :project_languages, :project_language_ids
  attr_accessible :report_languages, :report_language_ids

  attr_accessible :product_type, :product_type_id, :test_type
  attr_accessible :payment_requests, :payment_request_ids
  attr_accessible :main_components



  accepts_nested_attributes_for :test_platforms_bindings
  attr_accessible :test_platforms_bindings, :test_platforms_bindings_attributes

  attr_accessible :testers_by_platform

  scope :drafts, -> { where("completed_at is null") }
  scope :processing_projects, -> { where("completed_at is not null") }
  scope :tested_projects, -> { where("completed_at is not null and tested_at is not null") }

  def testers_by_platform=(platforms)
    return if platforms.nil?

    request_platform_bindings = platforms.map{|p| pp = {}; pp[:platform_id] = p[:platform_id]; pp[:testers_count] = p[:testers_count]; pp }
    current_platform_bindings = test_platforms_bindings.pluck_to_hash(:platform_id, :testers_count)
    current_platform_binding_ids = current_platform_bindings.map{|p| p[:platform_id] }

    request_platform_ids = request_platform_bindings.map{|p| p[:platform_id] }
    platform_ids_to_remove = current_platform_binding_ids.select{|current_platform_id| !request_platform_ids.include?(current_platform_id)  }


    new_platform_bindings = request_platform_bindings.select{|b| !current_platform_binding_ids.include?(b[:platform_id])  }

    # platform_bindings_to_update = request_platform_bindings.select{|b| current_platform_binding_ids.include?(b[:platform_id]) }.map do |existing_binding|
    #   existing_binding.map do |b|
    #     current_platform_bindings.select{|cb| b[:platform_id] == cb[:platform_id]}.first
    #   end
    # end

    platform_bindings_to_update = request_platform_bindings.select{|b| current_platform_binding_ids.include?(b[:platform_id]) }

    self.test_platforms_bindings.where(platform_id: platform_ids_to_remove, test_id: self.id).delete_all
    new_platform_bindings.each do |b|
      self.test_platforms_bindings.create!(platform_id: b[:platform_id], test_id: b[:test_id], testers_count: b[:testers_count])
    end

    platform_bindings_to_update.each do |b|
      p = self.test_platforms_bindings.where(platform_id: b[:platform_id]).first;
      if p[:testers_count] != b[:testers_count]
        p.update_attributes!(testers_count: b[:testers_count])
      end
    end

    puts "params_platforms: #{platforms}"
    puts "new_platform_bindings: #{new_platform_bindings}"
    puts "current_platform_bindings: #{current_platform_bindings.inspect}"
    puts "request_platform_bindings: #{request_platform_bindings.inspect}"
    puts "request_platform_ids: #{request_platform_ids.inspect}"
    puts "remove_ids: #{ platform_ids_to_remove.inspect }"


    #Wizard::TestPlatform.where(platform_id: platform_ids_to_remove, test_id: self.id).delete_all
    #
    # puts "testers_by_platform="
    # puts platforms.inspect
    # platforms.each do |k , p|
    #   platform_id = p['id'].to_i
    #   count = p['count'].to_i
    #   test_platform_binding = Wizard::TestPlatform.where(platform_id: platform_id, test_id: self.id).first
    #   if test_platform_binding.nil?
    #     test_platform_binding = Wizard::TestPlatform.new(test_id: self.id, platform_id: platform_id, testers_count: count)
    #
    #     test_platform_binding.save
    #
    #   elsif test_platform_binding.testers_count != count
    #     #test_platform_binding.testers_count = count
    #     test_platform_binding.update(testers_count: 5)
    #   end
    #
    #
    #
    #
    # end
    # platform_ids = platforms.map{|k, p| p['id'].to_i }
    # platforms_to_remove = Wizard::TestPlatform.where(test_id: self.id).where.not(platform_id: platform_ids)
    # platforms_to_remove.delete_all
  end



  def test_type_name
    test_type.try(&:name)
  end

  def product_type_name
    product_type.try(&:name)
  end

  def testers_by_platform
    test_platforms_bindings.pluck_to_hash(:platform_id, :testers_count)
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
    self.test_type.try {|t| t.image.path(:original) }
  end

  def pi__project_name
    name = self['project_name']
    name = "Test ##{self.id}" if name.blank?
    name
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
    return nil if test_type.nil?
    "#{test_type.name} test"
  end

  def testing_type
    "Explained"
  end

  def total_testers_count
    self.test_platforms_bindings.map{|p| p.testers_count }.select(&:present?).sum
  end

  def ps__hours
    hours_per_tester
  end

  def percent_completed_counter
    16
  end

  def completed?
    completed_at.present?
  end



  def report_name
    "Bugfix report v2.56"
  end

  def version_number
    2.56
  end

  # def product_type
  #   "games"
  # end

  def project_languages
    super.pluck(:name)
  end

  def project_languages=(value)
    langs = Wizard::ProjectLanguage.where(name: value)
    super langs
  end

  def report_languages
    super.pluck(:name)
  end

  def report_languages=(value)
    langs = Wizard::ReportLanguage.where(name: value)
    super langs
  end

  def project_access__url
    self['project_url']
  end

  # def platforms
  #   {
  #       ie: {testers_count: 53, logo_path: "ie", name: "Browsers", platform_subitems: [
  #           {name: "Internet Explorer 9", count: 1},
  #           {name: "Internet Explorer 10", count: 2}
  #       ]},
  #       ios: {testers_count: 3, logo_path: "ios", name: "IOS", platform_subitems: [
  #           {name: "Safary 3", count: 2}
  #       ]},
  #       android: { testers_count: 0, logo_path: "android", name: "Android" }}
  # end

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
    self['hours_per_tester'] || 1
  end

  def price
    total_testers_count * hours_per_tester * hour_price
  end

  def hour_price
    20
  end

  def steps_completed
    self.proceeded_steps_count
  end

  def proceeded_steps_count
    count = self['proceeded_steps_count']
    count ||= 0
    return count
  end

  def total_steps_count
    4
  end

  def active_step_number
    self['active_step_number'] || 1
  end


  def exploratory?
    methodology_type.blank? || methodology_type == "exploratory"
  end

  def test_case_driven?
    methodology_type == "test_case_driven"
  end

  def self.available_project_languages
    Wizard::ProjectLanguage.all.pluck(:name).to_json
  end

  def self.available_report_languages
    Wizard::ReportLanguage.all.pluck(:name).to_json
  end

  def remaining_time_string

    timespan = Time.diff(DateTime.now, self.expected_tested_at)
   # (self.expected_tested_at - DateTime.now).to_s

    total_days = timespan.total_days
    quantified_day_word = "days"
    if total_days % 10 == 1
      quantified_day_word = quantified_day_word.singularize
    end

    if total_days > 0
      "#{total_days} #{quantified_day_word}"
    end
  end

  def main_components
    self['main_components'].try{|s| s.split(",") } || []
  end

  def main_components=(val)
    self['main_components'] = val.try{|val| val.join(",")  }
  end

  # step_id

  def to_json
    to_builder.target!
  end

  def to_builder
    properties = %w(active_step_number auth_login auth_password authentication_required comment completed_at created_at current_step_id expected_tested_at exploratory_description hours_per_tester
id methodology_type percent_completed proceeded_steps_count product_type_id project_name project_url project_version state successful test_type_id test_type_name product_type_name tested_at updated_at user_id)

    Jbuilder.new do |t|
      # def prop(prop_name)
      #   test.send(prop_name, send(prop_name))
      # end
      #prop :active_step_number
      t.id id
      t.user_id user_id
      t.test_type_id test_type_id
      t.test_type test_type_name
      t.product_type_id product_type_id
      t.product_type product_type_name

      # platforms
      t.total_testers_count total_testers_count

      # test_info

      t.project_languages project_languages
      t.report_languages report_languages
      t.project_info_comment project_info_comment

      t.auth_login auth_login
      t.auth_password auth_password
      t.authentication_required authentication_required
      t.project_access_comment project_access_comment

      t.comment comment
      t.completed_at completed_at
      t.created_at created_at
      t.updated_at updated_at
      t.current_step_id current_step_id

      t.exploratory_instructions exploratory_description
      t.hours_per_tester hours_per_tester
      t.methodology_type methodology_type
      t.main_components main_components
      t.percent_completed percent_completed
      t.proceeded_steps_count proceeded_steps_count
      t.project_name project_name
      t.project_url project_url
      t.project_version project_version
      t.state state

      t.expected_tested_at expected_tested_at
      t.tested_at tested_at
      t.successful successful


      #test.president president.to_builder
    end
  end

  def complete!
    self.update_attributes!(completed_at: DateTime.now, skip_callbacks: true)
  end

end

