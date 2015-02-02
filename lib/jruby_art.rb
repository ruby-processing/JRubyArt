require 'rbconfig'

VERBOSE = true

unless defined? K9_ROOT
  $LOAD_PATH << File.expand_path(File.dirname(__FILE__))
  K9_ROOT = File.expand_path(File.dirname(__FILE__) + '/../')
end

# guard prevents issues with mri ruby when using creator
if RUBY_PLATFORM == 'java'
  def platform
    host_os = RbConfig::CONFIG['host_os']
    return '*mac-universal.jar' if host_os =~ /mac|darwin/
    bit = ENV_JAVA['sun.arch.data.model']
    if host_os =~ /linux/
      bit.eql?('32') ? '*linux-i586.jar' : '*linux-amd64.jar'
    elsif host_os =~ /cygwin|windows/
      bit.eql?('32') ? '*windows-i586.jar' : '*windows-amd64.jar'
    else
      '*armv6hf.jar'
    end
  end
  working_directory = File.join(File.dirname(__FILE__))
  $LOAD_PATH << working_directory unless $LOAD_PATH.include?(working_directory)
  Dir[File.join(working_directory, '*.jar')].each do |jar|
    require_relative jar unless jar =~ /native/
  end
  Dir[File.join(working_directory, platform)].each do |jar|
    require_relative jar
  end
  Java::ProcessingFastmath::DeglutLibrary.new.load(JRuby.runtime, false)
  Java::ProcessingVecmathVec2::Vec2Library.new.load(JRuby.runtime, false)
  Java::ProcessingVecmathVec3::Vec3Library.new.load(JRuby.runtime, false)
  AppRender = Java::ProcessingVecmath::AppRender
  ShapeRender = Java::ProcessingVecmath::ShapeRender
  require 'jruby_art/app'
  require 'jruby_art/helper_methods'
end

require 'jruby_art/version'
require 'jruby_art/helpers/numeric'
require 'jruby_art/helpers/range'
require 'jruby_art/runner'
