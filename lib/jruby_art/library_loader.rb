
class LibraryLoader
  attr_reader :libraries_path
  
  def initialize
    @libraries_path = "#{ENV['HOME']}/.jruby_art/libraries"
    @loaded_libraries = Hash.new(false)
  end  
   
  # Load a list of Ruby or Java libraries (in that order)
  # Usage: load_libraries :opengl, :boids
  #
  # If a library is put into a 'library' folder next to the sketch it will
  # be used instead of the library that ships with Ruby-Processing.
  def load_libraries(*args)
    installed_java_lib(*args)
  end
  alias_method :load_library, :load_libraries
  

  
  def installed_java_lib(*args)
    libraries = "#{ENV['HOME']}/.jruby_art/libraries/"
    args.each do |arg|
      lib = File.join(libraries, arg.to_s)
      jar_files = File.join(lib, '**', '*.jar')
      Dir.glob(jar_files).each do |jar|
        require jar
      end
    end
  end
end
