# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/jruby_art/java_opts'

JAVA = %w[-Xmx512 -Xms1G].freeze
JRUBY = %w[-J-Xmx512 -J-Xms1G].freeze
# Java Args Test
class JavaArgsTest < Minitest::Test
  attr_reader :root
  def setup
    @root = './'
  end

  def test_java
    assert_equal JAVA, JavaOpts.new(root).opts
  end

  def test_jruby
    assert_equal JRUBY, JRubyOpts.new(root).opts
  end
end
