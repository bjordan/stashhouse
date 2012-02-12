require 'rspec/core/rake_task'

desc "Run all specs and coverage with simplecov"
RSpec::Core::RakeTask.new do |t|
  t.pattern = "./spec/*_spec.rb"
end

task :default => :spec