# The LibraryLoader class adds some logic for loading library jars/ruby libraries
class LibraryLoader
  require_relative 'config'
  attr_reader :installed, :libraries_path, :loaded_libraries, :local
  
  def initialize
    @libraries_path = Processing::RP_CONFIG.fetch('LIBRARIES_PATH', "#{ENV['HOME']}/.jruby_art/libraries")
    @loaded_libraries = []
    sketch_root = defined?(SKETCH_ROOT).nil? ? Dir.pwd : SKETCH_ROOT
    @local = File.absolute_path("#{sketch_root}/library/")
    @installed = File.absolute_path("#{K9_ROOT}/library/")
  end
  
  # Load a list of Java libraries or ruby libraries
  # Usage: load_libraries :boids, :control_panel, :video
  #
  # If a library is put into a 'library' folder next to the sketch it will
  # be used instead of the library that ships with JRubyArt.
  def load_libraries(*args)
    args.each do |arg|
      next if loaded_libraries.include? arg
      local_ruby_lib(arg)
      local_java_lib(arg)
      installed_ruby_lib(arg)
      installed_java_lib(arg)
    end
  end
  
  def local_java_lib(arg)
    java_lib(local, arg)
  end
  
  def installed_java_lib(arg)
    java_lib(libraries_path, arg)
  end
  
  def installed_ruby_lib(arg)
    ruby_file = File.join(installed, format('%s/%s.rb', arg, arg))
    return unless FileTest.exist?(ruby_file)
    require ruby_file
    loaded_libraries << arg
  end
  
  def local_ruby_lib(arg)
    ruby_file = File.join(local, format('%s.rb', arg))
    return unless FileTest.exist? ruby_file
    require ruby_file
    loaded_libraries << arg
  end
  
  # HACK: For pure java libraries, such as the ones that are available
  # on this page: http://processing.org/reference/libraries/index.html
  # that include native code, we mess with the 'Java ClassLoader', so that
  # you don't have to futz with your PATH. But it's probably bad juju.
  def java_lib(path, library_name)
    library_name = library_name.to_sym
    jars = get_library_paths(path, library_name)
    jpath = format("%s/%s/library", path, library_name.to_s )
    return false if jars.empty?
    jars.each { |jar| require jar }
    platform_specific_library_paths = get_platform_specific_library_paths(jpath)
    platform_specific_library_paths = platform_specific_library_paths.select do |ppath|
      test(?d, ppath) && !Dir.glob(File.join(ppath, '*.{so,dll,jnilib}')).empty?
    end
    unless platform_specific_library_paths.empty?
      platform_specific_library_paths << java.lang.System.getProperty('java.library.path')
      new_library_path = platform_specific_library_paths.join(java.io.File.pathSeparator)
      java.lang.System.setProperty('java.library.path', new_library_path)
      field = java.lang.Class.for_name('java.lang.ClassLoader').get_declared_field('sys_paths')
      if field
        field.accessible = true
        field.set(java.lang.Class.for_name('java.lang.System').get_class_loader, nil)
      end
    end
    loaded_libraries << library_name
  end
  
  def platform
    match = %w(Mac Linux Windows).find do |os|
      java.lang.System.getProperty('os.name').index(os)
    end
    return 'other' unless match
    return match.downcase unless match =~ /Mac/
    'macosx'
  end
  
  def get_platform_specific_library_paths(basename)
    bits = 'universal' # for MacOSX, but does this even work, or does Mac return '64'?
    if java.lang.System.getProperty('sun.arch.data.model') == '32' ||
      java.lang.System.getProperty('java.vm.name').index('32')
      bits = '32'
    elsif java.lang.System.getProperty('sun.arch.data.model') == '64' ||
      java.lang.System.getProperty('java.vm.name').index('64')
      bits = '64' unless platform =~ /macosx/
    end
    [platform, platform + bits].map { |p| File.join(basename, p) }
  end
  
  def get_library_paths(path, library_name)
    lib = File.join(path, library_name.to_s)
    jar_files = File.join(lib, '**', '*.jar')
    Dir.glob(jar_files)
  end
end
