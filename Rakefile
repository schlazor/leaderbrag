# frozen_string_literal: true

require 'bundler/gem_tasks'
begin
  require 'rspec/core/rake_task'
  require 'rubocop/rake_task'
  require 'cucumber'
  require 'cucumber/rake/task'
  RSpec::Core::RakeTask.new(:spec)
  RuboCop::RakeTask.new(:style)
  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = '--format pretty'
  end
  desc 'run all checks'
  task :all do
    Rake::Task['style'].invoke
    Rake::Task['spec'].invoke
    Rake::Task['features'].invoke
  end
rescue LoadError
end

task default: :all
