# The LibraryLoader class add some logic for loading library jars
class LibraryLoader
  attr_reader :libraries_path, :loaded_libraries, :sketch_root, :local

  def initialize
    @libraries_path = "#{ENV['HOME']}/.jruby_art/libraries"
    @loaded_libraries = []
    @sketch_root = defined?(SKETCH_ROOT).nil? ? Dir.pwd : SKETCH_ROOT
    @local = File.absolute_path("#{sketch_root}/library/")
  end

  # Load a list of Java libraries
  # Usage: load_libraries :opengl, :boids
  #
  # If a library is put into a 'library' folder next to the sketch it will
  # be used instead of the library that ships with Ruby-Processing.
  def load_libraries(*args)
    local_ruby_lib(*args)
    local_java_lib(*args)
    installed_java_lib(*args)
  end

  def installed_java_lib(*args)
    libraries = "#{ENV['HOME']}/.jruby_art/libraries/"
    args.each do |arg|
      next if loaded_libraries.include? arg
      lib = File.join(libraries, arg.to_s)
      jar_files = File.join(lib, '**', '*.jar')
      Dir.glob(jar_files).each do |jar|
        require jar
      end
      loaded_libraries << arg
    end
  end

  def local_java_lib(*args)
    args.each do |arg|
      next if loaded_libraries.include? arg
      lib = File.join(local, arg.to_s)
      jar_files = File.join(lib, '**', '*.jar')
      Dir.glob(jar_files).each do |jar|
        require jar
      end
      loaded_libraries << arg
    end
  end
  
  def local_ruby_lib(*args)
    args.each do |arg|
      ruby_file = File.join(local, format('%s.rb', arg))
      next unless FileTest.exist? ruby_file
      require ruby_file
      loaded_libraries << arg
    end
  end
end
