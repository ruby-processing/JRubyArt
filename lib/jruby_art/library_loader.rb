# The LibraryLoader class add some logic for loading library jars
class LibraryLoader
  attr_reader :libraries_path, :loaded_libraries

  def initialize
    @libraries_path = "#{ENV['HOME']}/.jruby_art/libraries"
    @loaded_libraries = []
  end

  # Load a list of Java libraries
  # Usage: load_libraries :opengl, :boids
  #
  # If a library is put into a 'library' folder next to the sketch it will
  # be used instead of the library that ships with Ruby-Processing.
  def load_libraries(*args)
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
    library = "#{SKETCH_ROOT}/library/"
    args.each do |arg|
      lib = File.join(library, arg.to_s)
      jar_files = File.join(lib, '**', '*.jar')
      Dir.glob(jar_files).each do |jar|
        require jar
      end
      loaded_libraries << arg
    end
  end
end
