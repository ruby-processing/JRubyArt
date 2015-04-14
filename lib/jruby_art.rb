require 'rbconfig'

VERBOSE = true

unless defined? K9_ROOT
  $LOAD_PATH << File.expand_path(File.dirname(__FILE__))
  K9_ROOT = File.expand_path(File.dirname(__FILE__) + '/../')
end

# guard prevents issues with mri ruby when using creator
if RUBY_PLATFORM == 'java'
  working_directory = File.join(File.dirname(__FILE__))
  $LOAD_PATH << working_directory unless $LOAD_PATH.include?(working_directory)
  Dir[File.join(working_directory, '*.jar')].each do |jar|
    # require_relative jar unless jar =~ /native/ (breaks netbeans)
    require jar unless jar =~ /native/
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
