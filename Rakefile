require 'foodcritic'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

desc 'Run RuboCop style and lint checks'
RuboCop::RakeTask.new(:rubocop) do |t|
  t.options = ['-D']
end

desc 'Run Foodcritic lint checks'
FoodCritic::Rake::LintTask.new(:foodcritic) do |t|
  t.options = { :fail_tags => ['any', '~FC044'] }
end

desc 'Run ChefSpec examples'
RSpec::Core::RakeTask.new(:spec)

desc 'Run lint and unit tests'
task :test => [:rubocop, :foodcritic, :spec]
desc 'Run all tests'
task :testall => :test
task :default => :test

desc 'Run all tests and build the doc'
task :all => [:testall, :doc]

desc 'Build docs with knife cookbook doc'
task :doc do
  sh 'bundle exec knife cookbook doc ./'
end

begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new

  desc 'Alias for kitchen:all'
  task :integration => 'kitchen:all'

  task :testall => :integration
rescue LoadError
  puts '>>>>> Kitchen gem not loaded, omitting tasks' unless ENV['CI']
end
