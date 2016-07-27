# frozen_string_literal: false
# The SketchParameters class knows how to format, size, title & class name
class SketchParameters
  attr_reader :name, :args
  def initialize(name:, args:)
    @name = name
    @args = args
  end

  def class_name
    name.split('_').collect(&:capitalize).join
  end

  def sketch_title
    human = name.split('_').collect(&:capitalize).join(' ')
    format("sketch_title '%s'", human)
  end

  def sketch_size
    mode = args.length == 3 ? format(', %s', args[2].upcase) : ''
    return 'size 200, 200' if args.empty?
    format('size %d, %d%s', args[0].to_i, args[1].to_i, mode)
  end
end

# The file writer can write a sketch when given instance of Sketch type
class SketchWriter
  attr_reader :file, :param

  def initialize(path, args)
    @param = SketchParameters.new(name: path, args: args)
    @file = format('%s/%s.rb', File.dirname(path), path)
  end

  def write(creator)
    sketch = creator.code(param)
    File.open(file, 'w+') { |f| f.write sketch.join("\n") }
  end
end

# Implements method_lines, omits blank line after draw
class Sketch
  def method_lines(name, content, indent)
    one = format('%sdef %s', indent, name)
    two = content.empty? ? '' : format('  %s%s', indent, content)
    three = format('%send', indent)
    return [one, two, three] if /draw/ =~ name
    [one, two, three, '']
  end
end

# The sketch class creates an array of formatted sketch lines
class BareSketch < Sketch
  def code(param)
    lines = []
    lines.concat method_lines('settings', param.sketch_size, '')
    lines.concat method_lines('setup', param.sketch_title, '')
    lines.concat method_lines('draw', '', '')
  end
end

# A class wrapping module (used by ClassSketch and Emacs Sketch)
module Wrap
  def wrapped(param)
    lines = []    
    lines << format('class %s < Processing::App', param.class_name)
    lines.concat method_lines('settings', param.sketch_size, '  ')
    lines.concat method_lines('setup', param.sketch_title, '  ')
    lines.concat method_lines('draw', '', '  ')
    lines << 'end'
  end
end

# A simple class wrapped sketch
class ClassSketch < Sketch
  include Wrap
  def code(param)
    lines = [
      '# frozen_string_literal: false',
      ''
    ]
    lines.concat wrapped(param)
  end
end

# A sketch that will run with jruby, for emacs etc
class EmacsSketch < Sketch
  include Wrap
  def code(param)
    lines = [
      '# frozen_string_literal: false',
      "require 'jruby_art'",
      "require 'jruby_art/app'",
      '',
      'Processing::App::SKETCH_PATH = __FILE__.freeze',
      ''
    ]
    lines.concat wrapped(param)
    lines << ''
    lines << format('%s.new unless defined? $app', param.class_name)
  end
end
