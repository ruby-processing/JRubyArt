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
    assert obj.name =~ /windows/
    assert obj.extension =~ /\*.dll/
  end

  class NativeFolderTest < Minitest::Test
    def test_windows_native_folder
      obj = MacNativeFolder.new
      assert_kind_of NativeFolder, obj, 'Constructor Failed'
      assert obj.name =~ /macos/
      assert obj.extension =~ /\*.dylib/
    end
  end

  if RbConfig::CONFIG['host_os'].downcase =~ /linux/
    def test_native_folder
      obj = NativeFolder.new
      assert_instance_of NativeFolder, obj, 'Constructor Failed'
      assert obj.name =~ /linux/
      assert obj.extension =~ /\*.so/
    end
  end
end
