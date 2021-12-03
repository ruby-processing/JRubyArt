# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jruby_art/version'
require 'rake'

Gem::Specification.new do |spec|
  spec.name = 'jruby_art'
  spec.version = JRubyArt::VERSION
  spec.author  = 'Martin Prout'
  spec.email = 'mamba2928@yahoo.co.uk'
  spec.description = <<-DESCRIPTION
  JRubyArt-2.5.0+ is a ruby implementation of the processing art framework, with enhanced
  functionality. Processing libraries and ruby gems can be used in your sketches.
  Features create/run/watch/live modes.
  DESCRIPTION
  spec.summary = 'Code as Art, Art as Code. Processing and Ruby are meant for each other.'
  spec.homepage = 'https://ruby-processing.github.io/JRubyArt/'
  spec.post_install_message = "Use 'k9 --install' to install jruby-complete, and 'k9 --check' to check config."
  spec.licenses = %w[GPL-3.0 LGPL-2.0]
  spec.files = FileList['bin/**/*', 'lib/**/*', 'library/**/*', 'samples/**/*', 'vendors/Rakefile'].exclude(/jar/).to_a
  spec.files << "lib/jruby_art-#{JRubyArt::VERSION}.jar"
  spec.files << 'lib/gluegen-rt.jar'
  spec.files << 'lib/jogl-all.jar'
  spec.files << 'lib/gluegen-rt-natives-linux-amd64.jar'
  spec.files << 'lib/gluegen-rt-natives-macosx-universal.jar'
  # spec.files << 'lib/gluegen-rt-natives-ios-arm64.jar'
  spec.files << 'lib/gluegen-rt-natives-windows-amd64.jar'
  spec.files << 'lib/jogl-all-natives-linux-amd64.jar'
  spec.files << 'lib/jogl-all-natives-macosx-universal.jar'
  # spec.files << 'lib/jogl-all-natives-ios-arm64.jar'
  spec.files << 'lib/jogl-all-natives-windows-amd64.jar'
  spec.files << 'library/pdf/itextpdf-5.5.13.2.jar'
  spec.files << 'library/svg/batik-all-1.14.jar'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.5'
  spec.add_development_dependency 'minitest', '~> 5.10'
  spec.add_runtime_dependency 'rake', '~> 12.3'
  spec.requirements << 'A decent graphics card'
  spec.requirements << 'java runtime >= 11.0.3+'
end
