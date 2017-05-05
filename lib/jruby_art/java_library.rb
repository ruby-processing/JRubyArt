require_relative 'config'
require_relative 'native_folder'
require_relative 'native_loader'

# The JavaLibrary class
class JavaLibrary
  attr_reader :dir, :path, :ppath

  def initialize(name)
    @dir = '.'
    @path = File.join(dir, "#{name}.jar")
  end

  def exist?
    File.exist? path
  end

  def load_jars
    Dir["#{dir}/*.jar"].each do |jar|
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
  end
end

# The LocalJavaLibrary class
class LocalJavaLibrary < JavaLibrary
  def initialize(name)
    super
    @dir = File.join(Processing::SKETCH_ROOT, 'library', name)
    @path = File.join(dir, "#{name}.jar")
  end
end

# The InstalledJavaLibrary class
class InstalledJavaLibrary < JavaLibrary
  def initialize(name)
    super
    @dir = File.join(Processing::RP_CONFIG['sketchbook_path'], 'libraries')
    @path = File.join(dir, name, 'library', "#{name}.jar")
  end
end
