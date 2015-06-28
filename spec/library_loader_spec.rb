require_relative '../lib/jruby_art/library_loader'
require_relative '../lib/jruby_art/config'
require 'spec_helper'

describe 'LibraryLoader' do
  
  before :all do    
    K9_ROOT = "../"
    @library_loader = Processing::LibraryLoader.new 
  end

  METHODS = %i(library_loaded? load_library load_libraries)

  METHODS.each { |method_string|
    it "method: .#{method_string}" do
      expect(@library_loader).to respond_to(method_string).with(1).argument
    end
  }

  after :all do
    @library_loader = nil
  end
end
