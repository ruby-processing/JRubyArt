# frozen_string_literal: false

require_relative '../jruby_art'
require_relative 'config'
# require_relative 'sketchbook'
# The processing wrapper module
module Processing
  # Encapsulate library loader functionality as a class
  class LibraryLoader
    attr_reader :sketchbook_library_path

    def initialize
      @sketchbook_library_path = File.join(Processing::RP_CONFIG['sketchbook_path'], 'libraries')
      @loaded_libraries = Hash.new(false)
    end

    # Detect if a library has been loaded (for conditional loading)
    def library_loaded?(library_name)
      @loaded_libraries[library_name.to_sym]
    end

    # Load a list of Ruby or Java libraries (in that order)
    # Usage: load_libraries :opengl, :boids
    #
    # If a library is put into a 'library' folder next to the sketch it will
    # be used instead of the library that ships with JRubyArt.
    def load_libraries(*args)
      message = 'no such file to load -- %s'
      args.each do |lib|
        loaded = load_ruby_library(lib) || load_java_library(lib)
        raise(LoadError.new, format(message, lib)) unless loaded
      end
    end
    alias load_library load_libraries

    # For pure ruby libraries.
    # The library should have an initialization ruby file
    # of the same name as the library folder.
    def load_ruby_library(library_name)
      library_name = library_name.to_sym
      return true if @loaded_libraries.include?(library_name)
      path = get_library_paths(library_name, 'rb').first
      return false unless path
      @loaded_libraries[library_name] = (require path)
    end

    # HACK: For pure java libraries, such as the ones that are available
    # on this page: http://processing.org/reference/libraries/index.html
    # that include native code, we mess with the 'Java ClassLoader', so that
    # you don't have to futz with your PATH. But it's probably bad juju.
    def load_java_library(library_name)
      library_name = library_name.to_sym
      return true if @loaded_libraries.include?(library_name)
      jpath = get_library_directory_path(library_name) # defaults to jar
      jars = get_library_paths(library_name)
      return false if jars.empty?
      jars.each { |jar| require jar }
      platform_specific_library_paths = get_platform_specific_library_paths(jpath)
      platform_specific_library_paths = platform_specific_library_paths.select do |ppath|
        FileTest.directory?(ppath) && !Dir.glob(File.join(ppath, '*.{so,dll,jnilib}')).empty?
      end
      unless platform_specific_library_paths.empty?
        platform_specific_library_paths << get_property('java.library.path')
        new_library_path = platform_specific_library_paths.join(java.io.File.pathSeparator)
        java.lang.System.setProperty('java.library.path', new_library_path)
        field = java.lang.Class.for_name('java.lang.ClassLoader').get_declared_field('sys_paths')
        if field
          field.accessible = true
          field.set(java.lang.Class.for_name('java.lang.System').get_class_loader, nil)
        end
      end
      @loaded_libraries[library_name] = true
    end

    def platform
      match = %w(mac linux windows).find do |os|
        get_property('os.name').downcase.index(os)
      end
      return 'other' unless match
      return match unless match =~ /mac/
      'macosx'
    end

    def get_platform_specific_library_paths(basename)
      # for MacOS, but does this even work, or does Mac return '64'?
      bits = 'universal'
      if get_property('sun.arch.data.model') == '32' ||
         get_property('java.vm.name').index('32')
        bits = '32'
      elsif get_property('sun.arch.data.model') == '64' ||
            get_property('java.vm.name').index('64')
        bits = '64' unless platform =~ /macosx/
      end
      [platform, platform + bits].map { |p| File.join(basename, p) }
    end

    def get_library_paths(library_name, extension = 'jar')
      dir = get_library_directory_path(library_name, extension)
      Dir.glob("#{dir}/*.{rb,jar}")
    end

    protected

    def get_property(prop)
      java.lang.System.getProperty(prop)
    end

    def get_library_directory_path(library_name, extension = 'jar')
      extensions = extension ? [extension] : %w(jar rb)
      extensions.each do |ext|
        ProcessingPath.list(library_name).each do |jpath|
          if File.exist?(jpath) && !Dir.glob(format('%s/*.%s', jpath, ext)).empty?
            return jpath
          end
        end
      end
      nil
    end
  end  
end
