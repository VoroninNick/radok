def local_gem gem_name, **options
  local = true
  if local
    options[:path] ||= "gems/#{gem_name}"
  else
    options[:github] ||= "VoroninNick/#{gem_name}"
  end
  gem gem_name, options
end