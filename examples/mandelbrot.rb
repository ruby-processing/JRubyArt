# Mandelbrot Set example
# by Jordan Scales (http://jordanscales.com)
# Modified to use map1d (instead of map), and somewhat
# optimized (update_pixels instead of set, and dist for abs)
# default size 900x600
# no need to loop
require 'jruby_art'

class Mandelbrot < Processing::App
  def setup
    size 900, 600
    load_pixels
    no_loop
  end

  # main drawing method
  def draw
    (0...900).each do |x|
      (0...600).each do |y|
        c = Complex.new(map1d(x, (0...900), (-3..1.5)), map1d(y, (0...600), (-1.5..1.5)))
        # mandel will return 0 to 20 (20 is strong)
        #   map this to 0, 255 (and flip it)
        pixels[x + y * 900] = color(255 - map1d(mandel(c, 20), (0..20), (0..255)).to_i)
      end
    end
    update_pixels
  end

  # calculates the "accuracy" of a given point in the mandelbrot set
  #    : how many iterations the number survives without becoming chaotic
  def mandel(z, max = 10)
    score = 0
    c = z.clone
    while score < max
      # z = z^2 + c
      z.square
      z.add c
      break if z.abs > 2
      score += 1
    end
    score
  end

  #  Jordan Scales rolled his own Complex class
  #   stripped of all functionality, except for what he needed (abs, square, add, to_s)
  #
  class Complex
    include Processing::HelperMethods
    attr_accessor :real, :imag

    def initialize(real, imag)
      @real = real
      @imag = imag
    end

    # squares a complex number - overwriting it
    def square
      r = real * real - imag * imag
      i = 2 * real * imag

      @real = r
      @imag = i
    end

    # adds a given complex number
    def add(c)
      @real += c.real
      @imag += c.imag
    end

    # computes the magnitude (HelperMethods dist is a safer version of Math.hypot)
    def abs
      dist(real, imag, 0, 0)
    end

    def to_s
      "#{real} + #{imag}i"
    end
  end

end

Mandelbrot.new(title: 'Mandelbrot')