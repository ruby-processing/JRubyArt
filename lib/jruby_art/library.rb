require_relative 'native_folder'
require_relative 'native_loader'

require 'pathname'

# This class knows where to find JRubyArt libraries
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
        unless dir.directory?
          if Processing::RP_CONFIG.fetch('processing_ide', false)
            prefix = library_path
            @dir = Pathname.new(
              File.join(prefix, "libraries/#{name}/library")
            )
            @path = dir.join(Pathname.new("#{name}.jar"))
          else
            @dir = Pathname.new(
              File.join(ENV['HOME'], '.jruby_art', 'libraries', name, 'library')
            )
          end
          @path = dir.join(Pathname.new("#{name}.jar"))
        end
      end

      def library_path
        Processing::RP_CONFIG.fetch('library_path', "#{ENV['HOME']}/.jruby_art")
      end

      def ruby?
        path.extname == '.rb'
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
  
