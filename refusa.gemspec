Gem::Specification.new do |s|
  s.name              = 'refusa'
  s.version           = '0.0.1'
  s.date              = '2016-06-22'

  s.require_paths = %w[lib bin]
  # s.rdoc_options = ["--charset=UTF-8"]
  # s.extra_rdoc_files = %w[README.md LICENSE]
  s.executables = ["refusa"]
  s.default_executable = "refusa.rb"

  # = MANIFEST =
  s.files = %w[
    bin/refusa.rb
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
  ]
 
  # s.test_files = []

  # s.rubygems_version = %q{1.3.7}
  # s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  # if s.respond_to? :specification_version then
    # current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    # s.specification_version = 3
  # end
end