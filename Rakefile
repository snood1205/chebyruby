require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
end


desc 'Run tests'
task default: :test

task :clean do
  `rm *.gem`
end

task :build do
  `gem build chebyruby.gemspec`
end

task :deploy do
  `rake clean`
  `rake build`
  `gem push *.gem`
end
