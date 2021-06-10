# frozen_string_literal: true

require 'jruby'
require_relative '../jruby_art'
Dir["#{K9_ROOT}/lib/*.jar"].sort.each do |jar|
  require jar
end
require_relative '../jruby_art/helper_methods'
require_relative '../jruby_art/helpers/aabb'
require_relative '../jruby_art/library_loader'
require_relative '../jruby_art/config'

# A wrapper module for the processing App
module Processing
  # Include some core processing classes that we'd like to use:
  include_package 'processing.core'
  # Load vecmath, fastmath and mathtool modules
  Java::Monkstone::JRLibrary.load(JRuby.runtime)

  # import custom Vecmath renderers
  module Render
    java_import 'monkstone.vecmath.GfxRender'
    java_import 'monkstone.vecmath.ShapeRender'
  end
  # Watch the definition of these methods, to make sure
  # that Processing is able to call them during events.
  METHODS_TO_ALIAS ||= {
    mouse_pressed: :mousePressed,
    mouse_dragged: :mouseDragged,
    mouse_clicked: :mouseClicked,
    mouse_moved: :mouseMoved,
    mouse_released: :mouseReleased,
    key_pressed: :keyPressed,
    key_released: :keyReleased,
    key_typed: :keyTyped
  }.freeze
  class << self
    attr_accessor :app, :surface
  end
  # All sketches extend this class
  class App < PApplet
    include HelperMethods
    include Math
    include MathTool
    include Render
    include FastNoise
    # Alias some methods for familiarity for Shoes coders.
    # surface replaces :frame
    alias oval ellipse
    alias stroke_width stroke_weight
    alias rgb color
    alias gray color

    def sketch_class
      self.class.sketch_class
    end

    # Keep track of what inherits from the Processing::App, because we're
    # going to want to instantiate one.
    def self.inherited(subclass)
      super(subclass)
      @sketch_class = subclass
    end

    class << self
      # Handy getters and setters on the class go here:
      attr_reader :sketch_class, :library_loader

      def load_libraries(*args)
        @library_loader ||= LibraryLoader.new
        library_loader.load_library(*args)
      end
      alias load_library load_libraries

      def library_loaded?(library_name)
        library_loader.library_loaded?(library_name)
      end

      def load_ruby_library(*args)
        library_loader.load_ruby_library(*args)
      end

      def load_java_library(*args)
        library_loader.load_java_library(*args)
      end

      # When certain special methods get added to the sketch, we need to let
      # Processing call them by their expected Java names.
      def method_added(method_name) #:nodoc:
        return unless METHODS_TO_ALIAS.key?(method_name)

        alias_method METHODS_TO_ALIAS[method_name], method_name
      end
    end

    def library_loaded?(library_name)
      self.class.library_loaded?(library_name)
    end

    # Since processing-3.0 you should prefer setting the sketch width and
    # height and renderer using the size method in the settings loop of the
    # sketch (as with vanilla processing) but is hidden see created java.
    # Options are no longer relevant, define post_initialize method to use
    # custom options (see Sandi Metz POODR)

    def initialize(options = {})
      super()
      Processing.app = self
      post_initialize(options)
      proxy_java_fields
      mix_proxy_into_inner_classes
      java.lang.Thread.default_uncaught_exception_handler = proc do |_thread_, exception|
        puts(exception.class.to_s)
        puts(exception.message)
        puts(exception.backtrace.map { |trace| "\t#{trace}" })
        close
      end
      @surface = get_surface
      # NB: this is the processing runSketch() method as used by processing.py
      run_sketch
    end

    def size(*args)
      width, height, mode = *args
      @width ||= width
      @height ||= height
      @render_mode ||= mode
      import_opengl if /opengl/.match?(mode)
      super(*args)
    end

    def sketch_title(title)
      surface.set_title(title)
    end

    def sketch_path(spath = '')
      return super() if spath.empty?

      super(spath)
    end

    def data_path(dat)
      dat_root = File.join(SKETCH_ROOT, 'data')
      Dir.mkdir(dat_root) unless File.exist?(dat_root)
      File.join(dat_root, dat)
    end

    def sketch_size(x, y)
      surface.set_size(x, y)
    end

    def resizable(arg = true)
      surface.set_resizable(arg)
    end

    def on_top(arg = true)
      surface.set_always_on_top(arg)
    end

    def post_initialize(_args)
      nil
    end

    # Close and shutter a running sketch. But don't exit.
    # @HACK seems to work with watch until we find a better
    # way of disposing of sketch window...
    def close
      control_panel.remove if respond_to?(:control_panel)
      surface.stopThread
      surface.setVisible(false) if surface.isStopped
      dispose
      Processing.app = nil
    end

    def exit
      control_panel.remove if respond_to?(:control_panel)
      super()
    end

    private

    # Mix the Processing::Proxy into any inner classes defined for the
    # sketch, attempting to mimic the behavior of Java's inner classes.
    def mix_proxy_into_inner_classes
      klass = Processing::App.sketch_class
      klass.constants.each do |name|
        const = klass.const_get name
        next if const.class != Class || /^Java::/.match?(const.to_s)

        const.class_eval 'include Processing::Proxy', __FILE__, __LINE__
      end
    end

    def import_opengl
      # Include processing opengl classes that we'd like to use:
      opengl = 'processing.opengl.%s'
      %w[FontTexture FrameBuffer LinePath LineStroker PGL
         PGraphics2D PGraphics3D PGraphicsOpenGL PShader
         PShapeOpenGL Texture].each do |klass|
        java_import format(opengl, klass)
      end
    end
  end
  # Processing::App

  # @HACK purists may prefer 'forwardable' to the use of Proxy
  # Importing PConstants here to access the processing constants
  module Proxy
    include Math
    include HelperMethods
    include Java::ProcessingCore::PConstants

    def respond_to_missing?(name, include_private = false)
      Processing.app.respond_to?(name) || super
    end

    def method_missing(name, *args)
      app = Processing.app
      return app.send(name, *args) if app&.respond_to?(name)

      super
    end
  end
  # Processing::Proxy
end
# Processing
