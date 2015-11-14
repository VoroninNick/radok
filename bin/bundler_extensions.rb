def local_gem gem_name, **options
  local = true

  if local
    options[:path] ||= "gems/#{gem_name}"
    options.delete :branch
  else
    options[:github] ||= "VoroninNick/#{gem_name}"
  end
  gem gem_name, options
end