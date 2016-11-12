gem 'minitest'      # don't use bundled minitest
require 'minitest/autorun'
require 'minitest/pride'

Dir.chdir(File.dirname(__FILE__))

class Rp5Test < Minitest::Test

  def test_normal
    out, _err_ = capture_io do
      open('|../bin/k9 -r sketches/basic.rb', 'r') do |io|
        while l = io.gets
          puts(l.chop)
        end
      end
    end
    assert_match(/ok/, out, 'Failed Basic Sketch')
  end

  def test_sketch_path
    out, _err_ = capture_io do
      open('|../bin/k9 -r sketches/sketch_path.rb', 'r') do |io|
        while l = io.gets
          puts(l.chop)
        end
      end
    end
    assert_match('/home/tux/JRubyArt/test', out, 'Failed Sketch Path Sketch')
  end

  def test_on_top
    out, _err_ = capture_io do
      open('|../bin/k9 -r sketches/on_top.rb', 'r') do |io|
        while l = io.gets
          puts(l.chop)
        end
      end
    end
    assert_match(/ok/, out, 'Failed On Top Sketch')
  end

  def test_p2d
    out, _err_ = capture_io do
      open('|../bin/k9 -r sketches/p2d.rb', 'r') do |io|
        while l = io.gets
          puts(l.chop)
        end
      end
    end
    assert_match(/ok/, out, 'Failed P2D sketch')
  end

  def test_proc_root
    require 'psych'
    path = File.expand_path('~/.jruby_art/config.yml')
    config = FileTest.exist?(path)? Psych.load_file(path) : {}
    root = config.empty? ? '' : config['PROCESSING_ROOT']
    assert root =~ /processing/, 'You need to set your PROCESSING_ROOT in .rp5rc'
  end

  def test_fx2d
    out, _err = capture_io do
      open('|../bin/k9 -r sketches/fx2d.rb', 'r') do |io|
        while l = io.gets
          puts(l.chop)
        end
      end
    end
  end

  def test_p3d
    out, _err_ = capture_io do
      open('|../bin/k9 -r sketches/p3d.rb', 'r') do |io|
        while l = io.gets
          puts(l.chop)
        end
      end
    end
    assert_match(/ok/, out, 'Failed P3D sketch')
  end

  def test_graphics
    out, _err_ = capture_io do
      open('|../bin/k9 -r sketches/graphics.rb', 'r') do |io|
        while l = io.gets
          puts(l.chop)
        end
      end
    end
    assert out[0].to_i >= 3, "Graphics capability #{out} may be sub-optimal"
  end

  def test_setup_exception
    out, _err_ = capture_io do
      open('|../bin/k9 -r sketches/setup_ex.rb', 'r') do |io|
        while l = io.gets
          puts(l.chop)
        end
      end
    end
    assert out.index("undefined method `unknown_method'"), 'Failed to raise exception?'
  end
end
