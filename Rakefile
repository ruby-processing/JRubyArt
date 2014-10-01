# 
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
 

require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rubygems/package_task'
require 'rdoc/task'
require 'rake/testtask'
require 'rspec/core/rake_task'

spec = Gem::Specification.new do |s|
  s.name = 'jruby_art'
  s.version = '0.0.7'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.md', 'LICENSE.md']
  s.summary = 'Ruby processing development branch'
  s.description = s.summary
  s.author = 'Martin Prout'
  s.email = 'martin_p@lineone.net'
  # s.executables = ['rp5']
  s.files = %w(LICENSE.md README.md Rakefile) + Dir.glob("{bin,lib,spec}/**/*")
  s.require_path = "lib"
  s.bindir = "bin"
end

# -*- ruby -*-

require 'java'
require 'rake/javaextensiontask'

Rake::JavaExtensionTask.new('processing') do |ext|
  jars = FileList['lib/*.jar']
  ext.classpath = jars.map { |x| File.expand_path x}.join ':'
  ext.name = 'rpextras'
  ext.debug = true
  ext.lib_dir = 'lib'
  ext.source_version='1.7'
  ext.target_version='1.7'
end

Gem::PackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar = true
  p.need_zip = true
end

Rake::RDocTask.new do |rdoc|
  files =['README.md', 'LICENSE.md', 'lib/**/*.rb']
  rdoc.rdoc_files.add(files)
  rdoc.main = "README" # page to start on
  rdoc.title = "JRubyArt Docs"
  rdoc.rdoc_dir = 'doc/rdoc' # rdoc output folder
  rdoc.options << '--line-numbers'
end

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*.rb']
end

RSpec::Core::RakeTask.new do |spec|
  spec.pattern = 'spec/*_spec.rb'
  spec.rspec_opts = [Dir["lib"].to_a.join(':')]
end
