require_relative 'helper_methods'

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
    include Common, HelperMethods
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
      configure_sketch
      run_sketch
    end

    # This method provides the default setup for the sketch. It can
    # be overridden by the user for finer grained control.
    #
    def setup
      size(width, height)
    end

    # When certain special methods get added to the sketch, we need to let
    # Processing call them by their expected Java names.
    def self.method_added(method_name) # :nodoc:
      # Watch the definition of these methods, to make sure
      # that Processing is able to call them during events.
      if METHODS_TO_ALIAS.key?(method_name)
        alias_method METHODS_TO_ALIAS[method_name], method_name
      end
    end

    def pre
    end
     
  end

  # This class is for opengl sketches (P2D and P3D)
  class AppGL < PApplet
    include Processing, Common
    include_package 'processing.opengl' # imports the processing.opengl package.
    include HelperMethods
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

    # When certain special methods get added to the sketch, we need to let
    # Processing call them by their expected Java names.
    def self.method_added(method_name) #:nodoc:
      if METHODS_TO_ALIAS.key?(method_name)
        alias_method METHODS_TO_ALIAS[method_name], method_name
      end
    end
  end
end
