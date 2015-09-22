module Pages
  def self.table_name_prefix
    'pages_'
  end

  def self.all_class_names
    Dir[File.dirname(__FILE__) + "/pages/*.rb"].each {|f| require f }
    self.constants.map{|c| "#{self.to_s}::#{c}" }
  end
end
