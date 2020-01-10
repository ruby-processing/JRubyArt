require_relative 'test_helper'
require_relative '../lib/jruby_art/installer'

class InstallerTest < Minitest::Test
  attr_reader :installer, :jruby
  def setup
    @installer = Installer.new
    @jruby = JRubyInstaller.new
  end

  def test_new_installer
    assert installer.kind_of? Installer
    assert installer.respond_to? :install
    assert jruby.kind_of? JRubyInstaller
    assert jruby.respond_to? :install
  end
end
