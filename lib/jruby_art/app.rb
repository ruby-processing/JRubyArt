require_relative 'helper_methods'
require_relative 'library_loader'

# The Processing module is a wrapper for JRubyArt
# Author:: Martin Prout (extends / re-implements ruby-processing)
module Processing
  include_package 'processing.core' # imports the processing.core package.
  include_package 'processing.event'
  # This class is the base class the user should inherit from when making
  # their own sketch.
  #
  # i.e.
  #
  # class MySketch < Processing::App
  #
  #   def draw
  #     background rand(255)
  #   end
  #
  # end
  #
  module Common
    # This method provides the possibility of adding and using
    # new runtime options in sketches no need to re-define initialize
    #
    def post_initialize(_opts = {})
      nil
    end

    # This method configures the sketch title and and presentation mode.
    #
    def configure_sketch
      presentation_mode
      sketch_title
    end

    # This method sets the sketch presentation mode.
    #
    def presentation_mode
      return unless opts[:fullscreen]
      args << '--full-screen'
      args << "--bgcolor=#{opts[:bgcolor]}" if opts[:bgcolor]
    end

    # This method is the main draw loop of the sketch. This is usually
    # overridden by the user.
    #
    def draw
      nil
    end

    # This method runs the processing sketch.
    #
    def run_sketch
      PApplet.run_sketch(args.to_java(:string), self)
    end

    # This method sets the sketch title.
    #
    def sketch_title
      args << opts.fetch(:title, 'Sketch')
    end
  end
  # Watch the definition of these methods, to make sure
  # that Processing is able to call them during events.
  METHODS_TO_ALIAS = {
    mouse_pressed: :mousePressed,
    mouse_dragged: :mouseDragged,
    mouse_clicked: :mouseClicked,
    mouse_moved: :mouseMoved,
    mouse_released: :mouseReleased,
    key_pressed: :keyPressed,
    key_released: :keyReleased,
    key_typed: :keyTyped
  }

  # This class is for default (Java2D) sketches only
  class App < PApplet
    include Math, Common, HelperMethods
    attr_reader :title, :args, :opts

    class << self
      # Handy getters and setters on the class go here:
      attr_accessor :sketch_class, :library_loader

      def load_libraries(*args)
        library_loader ||= LibraryLoader.new
        library_loader.load_libraries(*args)
      end
      alias_method :load_library, :load_libraries

      # When certain special methods get added to the sketch, we need to let
      # Processing call them by their expected Java names.
      def method_added(method_name) #:nodoc:
        return unless METHODS_TO_ALIAS.key?(method_name)
        alias_method METHODS_TO_ALIAS[method_name], method_name
      end
    end

    def sketch_class
      self.class.sketch_class
    end

    # App should be instantiated with an optional list of opts
    # and array of args.
    #
    # App.new(title: 'My Simple App', fullscreen: true)
    #
    def initialize(opts = {}, args = [])
      super()
      proxy_java_fields
      post_initialize(opts)
      @args = args
      @opts = opts
      $app = self
      configure_sketch
      run_sketch
    end

    # This method provides the default setup for the sketch. It can
    # be overridden by the user for finer grained control.
    #
    def setup
      size(width, height)
    end
  end

  # This class is for opengl sketches (P2D and P3D)
  class AppGL < PApplet
    include Math, Processing, Common
    include_package 'processing.opengl' # imports the processing.opengl package.
    include HelperMethods
    Java::ProcessingVecmathArcball::ArcballLibrary.new.load(JRuby.runtime, false)
    attr_reader :title, :args, :opts

    # App should be instantiated with an optional list of opts
    # and array of args.
    #
    # App.new(title: 'My Simple App', fullscreen: true)
    #
    def initialize(opts = {}, args = [])
      super()
      proxy_java_fields
      post_initialize(opts)
      @args = args
      @opts = opts
      $app = self
      configure_sketch
      run_sketch
    end

    # This method provides the default setup for the sketch. It can
    # be overridden by the user for finer grained control.
    #
    def setup
      size(width, height, mode = P3D)
      fail unless /opengl/ =~ mode
    end

    class << self
      # Handy getters and setters on the class go here:
      attr_accessor :sketch_class, :library_loader

      def load_libraries(*args)
        library_loader ||= LibraryLoader.new
        library_loader.load_libraries(*args)
      end
      alias_method :load_library, :load_libraries

      # When certain special methods get added to the sketch, we need to let
      # Processing call them by their expected Java names.
      def method_added(method_name) #:nodoc:
        return unless METHODS_TO_ALIAS.key?(method_name)
        alias_method METHODS_TO_ALIAS[method_name], method_name
      end
    end
  end

  # Using :method_missing to mimic inner class methods and
  # :constant_missing to mimic access to inner class constants
  # @HACK you should consider using 'forwardable' to avoid this
  # egregious hack...
  module Proxy
    def method_missing(name, *args)
      return $app.send(name, *args) if $app && $app.respond_to?(name)
      super
    end

    def self.const_missing(name)
      return $app.class.const_get(name) if $app && $app.class.const_defined?(name)
      super
    end
  end
end
