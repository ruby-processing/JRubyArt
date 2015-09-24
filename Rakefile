
desc 'build and test'    
task :default => [:build_and_test]

task :build_and_test do
  Rake::Task[:compile].execute
  Rake::Task["gem"].execute  
  Rake::Task["test"].execute
end

desc 'Build and install gem'
task :install => :gem do
  sh "jruby -S gem install #{Dir.glob('*.gem').join(' ')} --no-ri --no-rdoc"
end

desc 'Uninstall gem'
task :uninstall do
  sh "gem uninstall -x jruby_art"	
end

desc 'Install jruby-complete'
task :install_jruby_complete do
  begin
    sh "cd vendors && rake"
  rescue
    warn("WARNING: you may not have wget installed")	    
  end
end

desc 'Compile'
task :compile do
  sh "jruby -S rake --rakefile JRakefile compile"
end

desc 'gem'
task :gem do
  sh "jruby -S gem build jruby_art.gemspec"
end

desc 'Test'
task :test do
  sh "jruby test/deglut_spec_test.rb"
  sh "jruby test/vecmath_spec_test.rb"
  sh "jruby test/math_tool_test.rb"
  sh "jruby test/helper_methods_test.rb"
  sh "jruby test/aabb_spec_test.rb"
  ruby "test/k9_run_test.rb"  	
end

desc 'clean'
task :clean do
  Dir['./**/*.%w{jar gem}'].each do |path|
    puts "Deleting #{path} ..."
    File.delete(path)
  end
  FileUtils.rm_rf('./tmp')
end
