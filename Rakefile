# This Rakefile has all the right settings to run the tests inside each lab
gem 'rspec'
require 'rspec/core/rake_task'

task :default => :spec

desc "run tests for chess game"
RSpec::Core::RakeTask.new do |task|
  lab = Rake.application.original_dir
  task.pattern = "#{lab}/*_spec.rb"
  task.verbose = false
end
