# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jruby_art/version'
require 'rake'

Gem::Specification.new do |spec|
  spec.name = "jruby_art"
  spec.version = JRubyArt::VERSION
  spec.authors = %w(Jeremy\ Ashkenas Guillaume\ Pierronnet Martin\ Prout)
  spec.email = "martin_p@lineone.net"
  spec.description = <<-EOS
  JRubyArt is a ruby wrapper for the processing art framework.
  The current version supports processing-3.0a11, and uses jruby-9.0.0.0
  as the glue between ruby and java. You can use both processing libraries and ruby
  gems in your sketches. Features create/run/watch modes. The "watch" mode,
  provides a nice REPL-ish way to work on your processing sketches. Includes:-
  A "Control Panel" library, so that you can easily create sliders, buttons,
  checkboxes and drop-down menus, and hook them into your sketch's instance
  variables and hundreds of worked examples to get you started...
  EOS
  spec.summary = %q{Code as Art, Art as Code. Processing and Ruby are meant for each other.}
  spec.homepage = "https://github.com/ruby-processing/JRubyArt"
  spec.post_install_message = %q{Use 'k9 setup install' to install jruby-complete, and 'k9 setup check' to check config.}
  spec.license = 'MIT'

  spec.files = FileList['bin/**/*', 'lib/**/*', 'library/**/*', 'samples/**/*', 'vendors/Rakefile'].exclude(/jar/).to_a
  spec.files << 'lib/rpextras.jar'

  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '>= 2.1'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", "~> 10.3"
  spec.add_development_dependency "rake-compiler", "~> 0.9"
  spec.add_development_dependency "minitest", "~> 5.3"
  spec.requirements << 'A decent graphics card'
  spec.requirements << 'java runtime >= 1.8+'
  spec.requirements << 'processing = 3.0a11+'
end
