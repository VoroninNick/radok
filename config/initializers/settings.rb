class Settings
  def self.[](arg)
    config = YAML.load_file(File.open(Rails.root.join("config/settings/development.yml")))
    arg = arg.to_s
    path_fragments = arg.split(".")
    res = config

    path_fragments.each do |f|
      res = res[f]
      if res.nil?
        return nil
      end
    end


    return res
  end

  def self.method_missing(symbol, *args, &block)
    self.send(:[], symbol, *args, &block) || super
  end
end