#!/usr/bin/env rake

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/lib')
require 'parliament'

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new

  task default: :spec
  task test: :spec
rescue LoadError
  warn 'Could not load RSpec tasks'
end

namespace :bundler do
  task :setup do
    require 'bundler/setup'
  end
end
