Gem::Specification.new do |s|
  s.name              = 'refusa'
  s.version           = '0.0.1'
  s.date              = '2016-06-22'

  s.authors     = ["Mike Hawk"]
  # s.email       = ["jesse@anysoft.us"]
  # s.homepage    = "http://anysoft.us"
  s.summary     = "refusa parser"
  s.description = "A nice parser"
  s.license     = "MIT"

  s.require_paths = %w[lib bin]
  # s.rdoc_options = ["--charset=UTF-8"]
  # s.extra_rdoc_files = %w[README.md LICENSE]
  s.executables = ["refusa"]
  s.default_executable = "refusa"

  # = MANIFEST =
  s.files = %w[
    lib/refusa/config.rb
    lib/refusa/db.rb
    lib/refusa/views.rb
    lib/refusa/walker.rb
    lib/refusa/views/main_form.rb
    lib/refusa/views/query.rb
    lib/refusa/walker/query.rb
    lib/refusa/walker/search_page.rb
    lib/refusa/walker/search.rb
    refusa.gemspec
    bin/refusa
  ]
  


  # s.add_dependency 'capybara'
  # s.add_dependency 'poltergeist'
  # s.add_dependency 'nokogiri'
  # s.add_dependency 'jdbc-sqlite3'
  # s.add_dependency 'sequel'
 
  # s.test_files = []

  s.rubygems_version = %q{2.6.4}
  # s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  # if s.respond_to? :specification_version then
    # current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    # s.specification_version = 3
  # end
end