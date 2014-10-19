require_relative './helpers/string'

module Processing
class Writer
  attr_reader :code, :file
  REQ = "require 'jruby_art'\n\n"
  KLASS = "class %s < %s \n\n"

  def initialize
    @code = []
    code << REQ
  end

  def read(input)
    @file = input
    source = File.read(input)
    opengl = !source.match(/P(2|3)D/).nil?
    name = File.basename(input).sub(/(\.rb)$/, '')
    mode = opengl ? "Processing::AppGL" : "Processing::App"
    code << format(KLASS, name.camelize, mode)
    IO.foreach(input) do |line|
      code << format("  %s", line)
    end
    code << "end\n\n"
    code << "#{name.camelize}.new(title: \"#{name.titleize}\")"
  end
  
  def write
    File.open(file, 'w') do |out|
      code.each do |line|
        out.write(line)
      end      
    end
  end
end
end
