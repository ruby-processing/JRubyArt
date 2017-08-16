require 'java'
require_relative '../jruby_art'
require_relative 'native_folder'
require_relative 'native_loader'

# The JavaLibrary class
class JavaLibrary
  attr_reader :dir, :path, :ppath

  def initialize(java_path)
    @dir = java_path.dir
    @path = java_path.path
  end

  def exist?
    File.exist? path
  end

  def load_jars
    Dir.glob("#{dir}/*.jar").each do |jar|
      require jar
    end
    return unless native_binaries?
    add_binaries_to_classpath
  end

  def native_binaries?
    native_folder = NativeFolder.new
    native = native_folder.name
    @ppath = File.join(dir, native)
    File.directory?(ppath) &&
      !Dir.glob(File.join(ppath, native_folder.extension)).empty?
  end

  def add_binaries_to_classpath
    native_loader = NativeLoader.new
    native_loader.add_native_path(ppath)
    true
  end
end

# The LocalJavaLibrary class
class LocalPath
  attr_reader :dir, :path
  def initialize(name)
    @dir = File.join(SKETCH_ROOT, 'library', name)
    @path = File.join(dir, "#{name}.jar")
  end
end

# The ProcessingJavaLibrary class
class ProcessingPath
  attr_reader :dir, :path
  def initialize(name)
    @dir = "#{Processing::RP_CONFIG['PROCESSING_ROOT']}/modes/java/libraries"
    @path = File.join(dir, name, 'library', "#{name}.jar")
  end
end

# The InstalledJavaLibrary class
class InstalledPath
  attr_reader :dir, :path
  def initialize(name)
    @dir = File.join(Processing::RP_CONFIG['sketchbook_path'], 'libraries')
    @path = File.join(dir, name, 'library', "#{name}.jar")
  end
end
