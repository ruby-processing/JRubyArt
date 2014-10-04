require_relative 'helper_methods'

module Processing
  include_package 'processing.core' # imports the processing.core package.

  # This class is the base class the user should inherit from when making
  # their own sketch.
  #
  # i.e.
  #
  # class MySketch < SimpleApp
  #
  #   def draw
  #     background rand(255)
  #   end
  #
  # end
  #
  class App < PApplet
    include HelperMethods
    attr_reader :title, :args, :opts

    # SimpleApp should be instantiated with an optional list of opts
    # and array of args.
    #
    # SimpleApp.new(width: 500, height: 500, fullscreen: true)
    #
    def initialize(opts = {}, args = [])
      # Guard against invalid input.
      fail TypeError unless opts.is_a? Hash
      fail TypeError unless args.is_a? Array
      # Set up the sketch.
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
      width  = opts.fetch(:width,  800)
      height = opts.fetch(:height, 640)
      size(width, height)
    end

    # This method provides the possibility of adding and using
    # new runtime options in sketches no need to re-define initialize
    #
    def post_initialize(_opts = {})
      nil
    end

    # This method is the main draw loop of the sketch. This must be
    # overridden by the user.
    #
    def draw
      nil
    end

    # This method runs the processing sketch.
    #
    def run_sketch
      PApplet.run_sketch(args, self)
    end

    # This method configures the sketch title and and presentation mode.
    #
    def configure_sketch
      sketch_title
      presentation_mode
    end

    # This method sets the sketch presentation mode.
    #
    def presentation_mode
      args << '--present' # if opts[:fullscreen]
    end

    # This method sets the sketch title.
    #
    def sketch_title
      args << opts.fetch(:title, 'Sketch')
    end

    # When certain special methods get added to the sketch, we need to let
    # Processing call them by their expected Java names.
    def self.method_added(method_name) #:nodoc:
      # Watch the definition of these methods, to make sure
      # that Processing is able to call them during events.
      methods_to_alias = {
        mouse_pressed:  :mousePressed,
        mouse_dragged:  :mouseDragged,
        mouse_clicked:  :mouseClicked,
        mouse_moved:    :mouseMoved,
        mouse_released: :mouseReleased,
        key_pressed:    :keyPressed,
        key_released:   :keyReleased,
        key_typed:      :keyTyped
      }
      if methods_to_alias.key?(method_name)
        alias_method methods_to_alias[method_name], method_name
      end
    end
  end
end
