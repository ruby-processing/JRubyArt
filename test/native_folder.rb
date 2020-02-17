# frozen_string_literal: true

require_relative 'test_helper'
require 'java'
require_relative '../lib/jruby_art/native_folder'
# Mock class
class WindowsNativeFolder < NativeFolder
  def initialize
    @os = 'mswin'
    @bit = 64
  end
end

# Mock Mac
class MacNativeFolder < NativeFolder
  def initialize
    @os = 'mac'
    @bit = 64
  end
end

# Test class
class NativeFolderTest < Minitest::Test
  def test_windows_native_folder
    obj = WindowsNativeFolder.new
    assert_kind_of NativeFolder, obj, 'Constructor Failed'
    assert(/windows/.match?(obj.name))
    assert(/\*.dll/.match?(obj.extension))
  end

  class NativeFolderTest < Minitest::Test
    def test_windows_native_folder
      obj = MacNativeFolder.new
      assert_kind_of NativeFolder, obj, 'Constructor Failed'
      assert(/macos/.match?(obj.name))
      assert(/\*.dylib/.match?(obj.extension))
    end
  end

  if /linux/.match?(RbConfig::CONFIG['host_os'].downcase)
    def test_native_folder
      obj = NativeFolder.new
      assert_instance_of NativeFolder, obj, 'Constructor Failed'
      assert(/linux/.match?(obj.name))
      assert(/\*.so/.match?(obj.extension))
    end
  end
end
