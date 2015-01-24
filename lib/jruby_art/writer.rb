require_relative './helpers/camel_string'
require_relative './helpers/string_extra'

module Processing
  # Wraps bare sketch with class wrapper etc
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
      default = source.match(/P(2|3)D/).nil?
      name = File.basename(input).sub(/(\.rb)$/, '')
      mode = default ? 'Processing::App' : 'Processing::AppGL'
      camel_name = CamelString.new(name).camelize
      code << format(KLASS, camel_name, mode)
      IO.foreach(input) do |line|
        code << format('  %s', line)
      end
      code << "end\n\n"
      title = StringExtra.new(name).titleize
      code << "#{camel_name}.new(title: \"#{title}\")"
    end

    def write
      File.open(file, 'w:UTF-8') do |out|
        code.each do |line|
          out.write(line)
        end
      end
    end
  end
end
