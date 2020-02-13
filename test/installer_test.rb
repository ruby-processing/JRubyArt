# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/jruby_art/installer'

# Installer test
class InstallerTest < Minitest::Test
  attr_reader :installer, :jruby
  def setup
    @installer = Installer.new
    @jruby = JRubyInstaller.new
  end

  def test_new_installer
    assert installer.is_a? Installer
    assert installer.respond_to? :install
    assert jruby.is_a? JRubyInstaller
    assert jruby.respond_to? :install
  end
end
