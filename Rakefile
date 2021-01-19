# frozen_string_literal: true

require_relative 'lib/jruby_art/version'
require 'erb'

MVN = Gem.win_platform? ? File.expand_path('mvnw.cmd') : File.expand_path('mvnw')

task default: %i[compile install_jogl gem test]

# depends on installed processing, with processing on path
desc 'Copy Jars'
task :install_jogl do
  # Temporarily load jogl-2.4.0-rc2021011 from a local directory
  jogl24 = File.join(ENV['HOME'], 'jogl-2.4-rc2021011')
  opengl = Dir.entries(jogl24).grep(/amd64|macosx-universal/)
  opengl.concat %w[jogl-all.jar gluegen-rt.jar]
  opengl.each do |gl|
    FileUtils.cp(File.join(jogl24, gl), File.join('.', 'lib'))
  end
end

desc 'Build gem'
task :gem do
  system 'jgem build jruby_art.gemspec'
end

desc 'Compile'
task :compile do
  system "#{MVN} package"
  FileUtils.mv "target/jruby_art-#{JRubyArt::VERSION}.jar", 'lib'
end

desc 'Test'
task :test do
  system 'jruby --dev test/deglut_spec_test.rb'
  system 'jruby --dev test/vecmath_spec_test.rb'
  system 'jruby --dev test/math_tool_test.rb'
  system 'jruby --dev test/helper_methods_test.rb'
  system 'jruby --dev test/aabb_spec_test.rb'
  system 'jruby --dev test/create_test.rb'
  system 'jruby --dev test/color_group_test.rb'
  home = File.expand_path('~')
  FLF = '%<home>s/.jruby_art/config.yml'
  config = File.exist?(format(FLF, home: home))
  if config
    system 'jruby test/k9_run_test.rb'
  else
    WNF = 'Create a config %<home>s/.jruby_art/config.yml to run sketch tests'
    warn format(WNF, home: home)
  end
end

desc 'JDeps Tool'
task :jdeps do
  system "#{MVN} jdeps:jdkinternals"
end

desc 'clean'
task :clean do
  Dir['./**/*.{jar,gem}'].each do |path|
    puts "Deleting #{path} ..."
    File.delete(path)
  end
  FileUtils.rm_rf('./target')
end
