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
  #gem.add_runtime_dependency 'sinatra'
  #gem.add_runtime_dependency 'json'
  #gem.add_runtime_dependency 'forgetful'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "forgetful-web #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
