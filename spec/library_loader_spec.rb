require_relative '../lib/jruby_art/library_loader'
require_relative '../lib/jruby_art/config'
require 'spec_helper'

describe LibraryLoader do
  
  before :all do    
    K9_ROOT = "../"
    @library_loader = LibraryLoader.new 
  end

  METHODS = %i(local_java_lib local_ruby_lib installed_java_lib installed_java_lib load_libraries)

  METHODS.each { |method_string|
    it "method: .#{method_string}" do
      expect(@library_loader).to respond_to(method_string)
    end
  }

  after :all do
    @library_loader = nil
  end
end
