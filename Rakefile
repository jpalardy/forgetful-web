require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "forgetful-web"
  gem.homepage = "http://github.com/jpalardy/forgetful-web"
  gem.license = "MIT"
  gem.summary = %Q{A sinatra front-end for the forgetful gem}
  gem.description = %Q{A sinatra front-end for the forgetful gem}
  gem.email = "jonathan.palardy@gmail.com"
  gem.authors = ["Jonathan Palardy"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

