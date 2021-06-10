require_relative 'test_helper'

Dir.chdir(File.dirname(__FILE__))

# Sketch tests
class Rp5Test < Minitest::Test
  def test_normal
    out, _err_ = capture_io do
      Kernel.open('|../bin/k9 -r sketches/basic.rb', 'r') do |io|
        while (l = io.gets)
          puts(l.chop)
        end
      end
    end
    assert_match(/ok/, out, 'Failed Basic Sketch')
  end

  def test_sketch_path
    out, _err_ = capture_io do
      Kernel.open('|../bin/k9 -r sketches/sketch_path.rb', 'r') do |io|
        while (l = io.gets)
          puts(l.chop)
        end
      end
    end
    assert_match('/home/tux/JRubyArt', out, 'Failed Sketch Path Sketch')
  end

  def test_on_top
    out, _err_ = capture_io do
      Kernel.open('|../bin/k9 -r sketches/on_top.rb', 'r') do |io|
        while (l = io.gets)
          puts(l.chop)
        end
      end
    end
    assert_match(/ok/, out, 'Failed On Top Sketch')
  end

  def test_p2d
    out, _err_ = capture_io do
      Kernel.open('|../bin/k9 -r sketches/p2d.rb', 'r') do |io|
        while (l = io.gets)
          puts(l.chop)
        end
      end
    end
    assert_match(/ok/, out, 'Failed P2D sketch')
  end

  def test_proc_root
    skip 'TODO: create a test for library configuration'
    require 'psych'
    path = File.expand_path('~/.jruby_art/config.yml')
    config = FileTest.exist?(path) ? Psych.load_file(path) : {}
    library = config.empty? ? '' : config['library_path']
    assert /librar/.match?(library), 'You need to set your library_path in .jruby_art/config.yml'
  end

  def test_fx2d
    skip 'Currently FX2D not implemented'
    out, _err = capture_io do
      Kernel.open('|../bin/k9 -r sketches/fx2d.rb', 'r') do |io|
        while (l = io.gets)
          puts(l.chop)
        end
      end
    end
  end

  def test_p3d
    out, _err_ = capture_io do
      Kernel.open('|../bin/k9 -r sketches/p3d.rb', 'r') do |io|
        while (l = io.gets)
          puts(l.chop)
        end
      end
    end
    assert_match(/ok/, out, 'Failed P3D sketch')
  end

  def test_graphics
    out, _err_ = capture_io do
      Kernel.open('|../bin/k9 -r sketches/graphics.rb', 'r') do |io|
        while (l = io.gets)
          puts(l.chop)
        end
      end
    end
    assert out[0].to_i >= 3, "Graphics capability #{out} may be sub-optimal"
  end

  def test_setup_exception
    out, _err_ = capture_io do
      Kernel.open('|../bin/k9 -r sketches/setup_ex.rb', 'r') do |io|
        while (l = io.gets)
          puts(l.chop)
        end
      end
    end
    assert out.index('undefined local variable or method `unknown_method'), 'Failed to raise exception?'
  end
end
