require_relative 'lib/jruby_art/version'
require 'erb'

task default: [:init, :create_manifest, :compile, :gem, :test]

# depends on installed processing, with processing on path
desc 'Copy Jars'
task :init do
  processing_root = File.dirname(`readlink -f $(which processing)`) # for Archlinux etc
  # processing_root = File.join(ENV['HOME'], 'processing-3.5.3') # alternative for debian linux etc
  jar_dir = File.join(processing_root, 'core', 'library')
  opengl = Dir.entries(jar_dir).grep(/amd64|macosx-universal/)
  opengl.concat %w[jogl-all.jar gluegen-rt.jar]
  opengl.each do |gl|
    FileUtils.cp(File.join(jar_dir, gl), File.join('.', 'lib'))
  end
end

desc 'Create jar Manifest'
task :create_manifest do
  manifest = ERB.new <<~MANIFEST
    Implementation-Title: jruby_art
    Implementation-Version: <%= JRubyArt::VERSION %>
    Class-Path: gluegen-rt.jar jog-all.jar
  MANIFEST

  File.open('MANIFEST.MF', 'w') do |f|
    f.puts(manifest.result(binding))
  end
end

desc 'Build gem'
task :gem do
  system 'gem build jruby_art.gemspec'
end

desc 'Compile'
task :compile do
  system 'mvn package'
  FileUtils.mv('target/jruby_art.jar', 'lib')
end

desc 'Test'
task :test do
  system 'jruby test/deglut_spec_test.rb'
  system 'jruby test/vecmath_spec_test.rb'
  system 'jruby test/math_tool_test.rb'
  system 'jruby test/helper_methods_test.rb'
  system 'jruby test/aabb_spec_test.rb'
  system 'jruby test/create_test.rb'
  system 'jruby test/color_group_test.rb'
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
