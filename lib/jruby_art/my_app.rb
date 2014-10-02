
require 'jruby_art'

class MyApp < Processing::App
  def setup
    size 200, 200
  end

  def draw

  end
end

MyApp.new(title: 'My App')
