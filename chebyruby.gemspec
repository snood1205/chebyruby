Gem::Specification.new do |s|
  s.name = 'ChebyRuby'
  s.summary = 'A gem for numerical analysis and scientific computing.'
  s.description =<<EOF
This is a gem that is mainly for numerical analysis and especially
for applications of numerical analysis with regards to univariate
calculus. The future of this gem might entail expansion towards the
world of matrix analysis and multivariate calculus, but the primary
goal for the time being is univariate numerical calculus.
EOF
  s.version = '0.1.1'
  s.author = 'Eli Sadoff'
  s.email = 'snood1205@gmail.com'
  s.license = 'MIT'
  s.platform = Gem::Platform::RUBY
  s.required_rubygems_version = '>=1.9.3'
  s.date = '2016-12-15'
  s.files = %w(Rakefile lib/chebyruby.rb bin/chebyruby) + Dir['lib/chebyruby/*.rb']
  s.files.concat Dir['**/*.rdoc']
  s.test_files = Dir['test/test_*.rb']
  s.homepage = 'https://github.com/snood1205/chebyruby'
  s.require_paths = %w(lib)
  s.has_rdoc = true
  s.extra_rdoc_files = 'README.md'
  s.rdoc_options << '-t' << 'chebyruby RDocs' << '-m' << 'README.md'
end
