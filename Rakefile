require_relative 'lib/jruby_art/version'
require 'erb'

task default: [:compile, :install_jogl, :gem, :test]

# depends on installed processing, with processing on path
desc 'Copy Jars'
task :install_jogl do
  processing_root = File.dirname(`readlink -f $(which processing)`) # for Archlinux etc
  # processing_root = File.join(ENV['HOME'], 'processing-3.5.3') # alternative for debian linux etc
  jar_dir = File.join(processing_root, 'core', 'library')
  opengl = Dir.entries(jar_dir).grep(/amd64|macosx-universal/)
  opengl.concat %w[jogl-all.jar gluegen-rt.jar]
  opengl.each do |gl|
    FileUtils.cp(File.join(jar_dir, gl), File.join('.', 'lib'))
  end
end

desc 'Build gem'
task :gem do
  system 'gem build jruby_art.gemspec'
end

desc 'Compile'
task :compile do
  system 'mvn package'
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
  config = File.exist?(format('%s/.jruby_art/config.yml', home))
  if config
    ruby 'test/k9_run_test.rb'
  else
    warn format('You should create %s/.jruby_art/config.yml to run sketch tests', home)
  end
end

desc 'clean'
task :clean do
  Dir["./**/*.{jar,gem}"].each do |path|
    puts "Deleting #{path} ..."
    File.delete(path)
  end
  FileUtils.rm_rf('./target')
end
