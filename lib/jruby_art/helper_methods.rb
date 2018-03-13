# frozen_string_literal: false
# processing module wrapper
require_relative '../rpextras'

module Processing
  # Provides some convenience methods
  module HelperMethods
    # processings epsilon may not be defined yet
    EPSILON ||= 9.999999747378752e-05
    # Nice block method to draw to a buffer.
    # You can optionally pass it a width, a height, and a renderer.
    # Takes care of starting and ending the draw for you.
    def buffer(buf_width = width, buf_height = height, renderer = @render_mode)
      create_graphics(buf_width, buf_height, renderer).tap do |buffer|
        buffer.begin_draw
        yield buffer
        buffer.end_draw
      end
    end

    def kamera(
      eye: Vec3D.new(width / 2.0, height / 2.0, (height / 2.0) / tan(PI * 30.0 / 180.0)),
      center: Vec3D.new(width / 2.0, height / 2.0, 0),
      up: Vec3D.new(0, 1.0, 0)
    )
      camera(eye.x, eye.y, eye.z, center.x, center.y, center.z, up.x, up.y, up.z)
    end

    def perspektiv(
      fov: Math::PI / 3.0,
      aspect_ratio: width.to_f / height,
      near_z: (height / 20.0) / tan(fov / 2.0),
      far_z: (height * 5) / tan(fov / 2.0)
    )
      perspective(fov, aspect_ratio, near_z, far_z)
    end

    # A nice method to run a given block for a grid.
    # Lifted from action_coding/Nodebox.
    # def grid(cols, rows, col_size = 1, row_size = 1) { |x, y| block_stuff }
    # NB: now implemented in java

    # lerp_color takes three or four arguments, in Java that's two
    # different methods, one regular and one static, so:
    def lerp_color(*args)
      args.length > 3 ? self.class.lerp_color(*args) : super(*args)
    end

    # hue, sat, brightness in range 0..1.0 returns RGB color int
    def hsb_color(hue, sat, brightness)
      Java::Monkstone::ColorUtil.hsbToRgB(hue, sat, brightness)
    end

    def color(*args)
      return super(*args) unless args.length == 1
      super(hex_color(args[0]))
    end

    def web_to_color_array(web)
      Java::Monkstone::ColorUtil.webArray(web)
    end

    def int_to_ruby_colors(p5color)
      warn "[DEPRECATION] `int_to_ruby_colors` is deprecated.  Please use `p52ruby` instead."
      p52ruby(p5color)
    end

    def p52ruby(p5color)
      Java::Monkstone::ColorUtil.rubyString(p5color)
    end

    # Overrides Processing convenience function thread, which takes a String
    # arg (for a function) to more rubylike version, takes a block...
    def thread(&block)
      if block_given?
        Thread.new(&block)
      else
        raise ArgumentError, 'thread must be called with a block', caller
      end
    end

    # explicitly provide 'processing.org' min instance method
    # to return a float:- a, b and c need to be floats
    # you might choose to use ruby method directly and then
    # provide a block to alter comparator eg
    # args.min(&block) # { |a, b| a.value <=> b.value }

    def min(*args)
      args.min
    end

    # explicitly provide 'processing.org' max instance method
    # to return a float:- a, b and c need to be floats see above

    def max(*args)
      args.max
    end

    # explicitly provide 'processing.org' dist instance method
    def dist(*args)
      case args.length
      when 4
        return dist2d(*args)
      when 6
        return dist3d(*args)
      else
        raise ArgumentError, 'takes 4 or 6 parameters'
      end
    end

    # Uses PImage class method under hood
    def blend_color(c1, c2, mode)
      Java::ProcessingCore::PImage.blendColor(c1, c2, mode)
    end

    # There's just so many functions in Processing,
    # Here's a convenient way to look for them.
    def find_method(method_name)
      reg = Regexp.new(method_name.to_s, true)
      methods.sort.select { |meth| reg.match(meth) }
    end

    # Proxy over a list of Java declared fields that have the same name as
    # some methods. Add to this list as needed.
    def proxy_java_fields
      fields = %w(key frameRate mousePressed keyPressed)
      methods = fields.map { |field| java_class.declared_field(field) }
      @declared_fields = Hash[fields.zip(methods)]
    end

    # Fix java conversion problems getting the last key
    # If it's ASCII, return the character, otherwise the integer
    def key
      int = @declared_fields['key'].value(java_self)
      int < 256 ? int.chr : int
    end

    # Provide a convenient handle for the Java-space version of self.
    def java_self
      @java_self ||= to_java(Java::ProcessingCore::PApplet)
    end

    # Fields that should be made accessible as under_scored.
    define_method(:mouse_x) { mouseX }

    define_method(:mouse_y) { mouseY }

    define_method(:pmouse_x) { pmouseX }

    define_method(:pmouse_y) { pmouseY }

    define_method(:frame_count) { frameCount }

    define_method(:mouse_button) { mouseButton }

    define_method(:key_code) { keyCode }

    # Ensure that load_strings returns a real Ruby array
    def load_strings(file_or_url)
      loadStrings(file_or_url).to_a
    end

    # Writes an array of strings to a file, one line per string.
    # This file is saved to the sketch's data folder
    def save_strings(filename, strings)
      saveStrings(filename, [strings].flatten.to_java(:String))
    end

    # frame_rate needs to support reading and writing
    def frame_rate(fps = nil)
      return @declared_fields['frameRate'].value(java_self) unless fps
      super(fps)
    end

    # Is the mouse pressed for this frame?
    def mouse_pressed?
      @declared_fields['mousePressed'].value(java_self)
    end

    # Is a key pressed for this frame?
    def key_pressed?
      @declared_fields['keyPressed'].value(java_self)
    end

    private

    FIXNUM_COL = -> (x) { x.is_a?(Integer) }
    STRING_COL = -> (x) { x.is_a?(String) }
    FLOAT_COL = -> (x) { x.is_a?(Float) }
    # parse single argument color int/double/String
    def hex_color(a)
      case a
      when FIXNUM_COL
        Java::Monkstone::ColorUtil.colorLong(a)
      when STRING_COL
        return Java::Monkstone::ColorUtil.colorString(a) if a =~ /#\h+/
        raise StandardError, 'Dodgy Hexstring'
      when FLOAT_COL
        Java::Monkstone::ColorUtil.colorDouble(a)
      else
        raise StandardError, 'Dodgy Color Conversion'
      end
    end

    def dist2d(*args)
      dx = args[0] - args[2]
      dy = args[1] - args[3]
      return 0 if dx.abs < EPSILON && dy.abs < EPSILON
      Math.hypot(dx, dy)
    end

    def dist3d(*args)
      dx = args[0] - args[3]
      dy = args[1] - args[4]
      dz = args[2] - args[5]
      return 0 if dx.abs < EPSILON && dy.abs < EPSILON && dz.abs < EPSILON
      Math.sqrt(dx * dx + dy * dy + dz * dz)
    end
  end
end
