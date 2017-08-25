require_relative 'native_folder'
require_relative 'native_loader'

require 'pathname'

BUNDLED = %r{pdf|net|dxf|svg|serial}
# This class knows where to find propane libraries
class Library
  require_relative '../jruby_art'
  require_relative './config'
  attr_reader :name, :path, :dir, :ppath

  def initialize(name)
    @name = name
    @ruby = true
  end

  def locate
    return if (@path = Pathname.new(
      File.join(SKETCH_ROOT, 'library', name, "#{name}.rb")
    )).exist?
    return if (@path = Pathname.new(
      File.join(K9_ROOT, 'library', name, "#{name}.rb")
    )).exist?
    locate_java
  end

  def locate_java
    @dir = Pathname.new(
      File.join(SKETCH_ROOT, 'library', name)
    )
    return @path = dir.join(Pathname.new("#{name}.jar")) if dir.directory?
    locate_installed_java
  end

  def locate_installed_java
    prefix = bundled? ? File.join(root, 'modes/java') : sketchbook
    @dir = Pathname.new(
      File.join(prefix, "libraries/#{name}/library")
    )
    @path = dir.join(Pathname.new("#{name}.jar"))
  end

  def sketchbook
    Processing::RP_CONFIG.fetch('sketchbook_path', "#{ENV['HOME']}/sketchbook")
  end

  def root
    Processing::RP_CONFIG.fetch('PROCESSING_ROOT', "#{ENV['HOME']}/processing")
  end

  def ruby?
    path.extname == '.rb'
  end

  def bundled?
    BUNDLED =~ name
  end

  def exist?
    path.exist?
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
  end
end
