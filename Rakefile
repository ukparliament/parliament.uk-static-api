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

task :populate_data do
  require 'net/http'
  require 'nokogiri'

  REQUEST_BASE_URL = 'https://api.parliament.uk/Staging/fixed-query/'

  raw_routes_html = Net::HTTP.get(URI(REQUEST_BASE_URL))
  document = Nokogiri::HTML.parse(raw_routes_html)
  routes = document.css('a').map { |link| link['href'] }
  dirs_to_generate = routes.map { |route| route.split('?')[0] }

  dirs_to_generate.zip(routes).each do |directory, route|
    sleep 30
    path = File.join(Dir.pwd, "lib/parliament/data/api/v1/#{directory}")
    unless Dir.exist?(path)
      Dir.mkdir(path)
      File.open("#{path}/index", 'w') { |file| file.write(Net::HTTP.get(URI("#{REQUEST_BASE_URL}#{URI.encode(route)}")).gsub('\'','"')) }
    end
  end
end
