# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jruby_art/version'
require 'rake'

Gem::Specification.new do |spec|
  spec.name = 'jruby_art'
  spec.version = JRubyArt::VERSION
  spec.authors = %w(Jeremy\ Ashkenas Guillaume\ Pierronnet Martin\ Prout)
  spec.email = 'mamba2928@yahoo.co.uk'
  spec.description = <<-EOS
  JRubyArt is a ruby wrapper for the processing art framework.
  This version uses 'optparse', run becomes --run (or -r) and 'setup install' 
  becomes '--install' or (-i) etc. Use both processing libraries and ruby gems 
  in your sketches. Features create/run/watch/live modes. The "--watch" mode,
  provides a nice REPL-ish way to work on your processing sketches. Includes:-
  A "Control Panel" library, so that you can easily create sliders, buttons,
  checkboxes and drop-down menus, and hook them into your sketch's instance
  variables and hundreds of worked examples to get you started...
  EOS
  spec.summary = %q{Code as Art, Art as Code. Processing and Ruby are meant for each other.}
  spec.homepage = "https://ruby-processing.github.io/JRubyArt/"
  spec.post_install_message = %q{Use 'k9 --install' to install jruby-complete, and 'k9 --check' to check config.}
  spec.license = 'MIT'

  spec.files = FileList['bin/**/*', 'lib/**/*', 'library/**/*', 'samples/**/*', 'vendors/Rakefile'].exclude(/jar/).to_a
  spec.files << 'lib/rpextras.jar'

  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.3'
  spec.add_development_dependency 'rake', '~> 11.1'
  spec.add_development_dependency 'minitest', '~> 5.8'
  spec.requirements << 'A decent graphics card'
  spec.requirements << 'java runtime >= 1.8.0_102+'
  spec.requirements << 'processing = 3.2.1+'
end
