require_relative 'test_helper'

JAVA = %w(java -Xmx512 -Xms1G -cp /home/tux/JRubyArt/lib/ruby/jruby-complete.jar org.jruby.Main watch)
JRUBY = %w(jruby -J-Xmx512 -J-Xms1G watch)

class JavaArgsTest < Minitest::Test
  attr_reader :root
  def setup
  end

  def test_java
    assert_equal JAVA.flatten, Processing::Command.new(executable: 'java', runner: 'watch', args: []).cmd('./')
  end

  def test_jruby
    assert_equal JRUBY.flatten, Processing::Command.new(executable: 'jruby', runner: 'watch', args: []).cmd('./')
  end
end
