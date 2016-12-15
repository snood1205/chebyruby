Gem::Specification.new do |s|
  s.name = 'ChebyRuby'
  s.version = '0.0.2.pre'
  s.default_executable = 'chebyruby'
  s.required_rubygems_version = Gem::Requirement.new('>= 0') if s.respond_to? :required_rubygems_version=  
  s.authors = ['Eli Sadoff']
  s.license = 'MIT'
  s.date = '2016-12-15'
  s.description = 'A gem for numerical analysis and scientific computing.'
  s.email = 'snood1205@gmail.com'
  s.files = %w(Rakefile lib/chebyruby.rb bin/chebyruby) + Dir['lib/chebyruby/*.rb']
  s.test_files = Dir['test/test_*.rb']
  s.homepage = 'https://github.com/snood1205/chebyruby'
  s.require_paths = %w(lib)
  s.rubygems_version = '2.5.1'
  s.summary = s.description + 'This is a pre-release so beware.'
end
