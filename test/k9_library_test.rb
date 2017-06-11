gem 'minitest'      # don't use bundled minitest
require 'minitest/autorun'
require 'minitest/pride'

Dir.chdir(File.dirname(__FILE__))

class Rp5LibraryTest < Minitest::Test

  def test_local_ruby
    out, _err_ = capture_io do
      open('|../bin/k9 -r sketches/local_ruby.rb', 'r') do |io|
        while l = io.gets
          puts(l.chop)
        end
      end
    end
    assert_match(/ok/, out, 'Failed Local Ruby Sketch')
  end

  def test_installed_ruby
    out, _err_ = capture_io do
      open('|../bin/k9 -r sketches/installed_ruby.rb', 'r') do |io|
        while l = io.gets
          puts(l.chop)
        end
      end
    end
    assert_match(/ok/, out, 'Failed Installed Ruby Sketch')
  end

  def test_local_java
    out, _err_ = capture_io do
      open('|../bin/k9 -r sketches/local_java.rb', 'r') do |io|
        while l = io.gets
          puts(l.chop)
        end
      end
    end
    assert_match(/ok/, out, 'Failed Local Java Sketch')
  end

  def test_processing_java
    out, _err_ = capture_io do
      open('|../bin/k9 -r sketches/processing_java.rb', 'r') do |io|
        while l = io.gets
          puts(l.chop)
        end
      end
    end
    assert_match(/ok/, out, 'Failed Local Java Sketch')
  end

  def test_installed_java
    out, _err_ = capture_io do
      open('|../bin/k9 -r sketches/installed_java.rb', 'r') do |io|
        while l = io.gets
          puts(l.chop)
        end
      end
    end
    assert_match(/ok/, out, 'Failed Installed Java Sketch')
  end
end
