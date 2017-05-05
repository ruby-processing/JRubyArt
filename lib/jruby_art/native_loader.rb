# This class knows how to dynamically set the 'java' native library path
# It might not work with java 9?
class NativeLoader
  attr_reader :separator, :current_path

  module JC
    java_import 'java.lang.Class'
    java_import 'java.lang.System'
    java_import 'java.io.File'
  end

  def initialize
    @separator = JC::File.pathSeparatorChar
    @current_path = JC::System.getProperty('java.library.path')
  end

  def add_native_path(pth)
    current_path << separator << pth
    JC::System.setProperty('java.library.path', current_path)
    field = JC::Class.for_name('java.lang.ClassLoader')
                     .get_declared_field('sys_paths')
    return unless field
    field.accessible = true # some jruby magic
    field.set(JC::Class.for_name('java.lang.System').get_class_loader, nil)
  end
end
