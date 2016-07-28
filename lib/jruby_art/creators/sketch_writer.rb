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
    mode = args.length == 3 ? format(', %s', args[2].upcase) : BLANK
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

# Implements methods and class_methods omits blank line after draw
# uses private method_lines to format method lines
class Sketch
  BLANK ||= ''.freeze
  INDENT ||= '  '.freeze

  def methods(param, indent)
    lines = []
    lines.concat method_lines('settings', param.sketch_size, indent)
    lines.concat method_lines('setup', param.sketch_title, indent)
    lines.concat method_lines('draw', BLANK, indent)
  end

  def class_methods(param)
    lines = [format('class %s < Processing::App', param.class_name)]
    lines.concat methods(param, INDENT)
    lines << 'end'
  end

  private

  def method_lines(name, content, indent)
    one = format('%sdef %s', indent, name)
    two = content.empty? ? BLANK : format('  %s%s', indent, content)
    three = format('%send', indent)
    return [one, two, three] if /draw/ =~ name
    [one, two, three, BLANK]
  end
end

# The sketch class creates an array of formatted sketch lines
class BareSketch < Sketch
  def code(param)
    methods(param, BLANK)
  end
end

# A simple class wrapped sketch
class ClassSketch < Sketch
  def code(param)
    lines = [
      '# frozen_string_literal: false',
      BLANK
    ]
    lines.concat class_methods(param)
  end
end

# A sketch that will run with jruby, for emacs etc
class EmacsSketch < Sketch
  def code(param)
    lines = [
      '# frozen_string_literal: false',
      "require 'jruby_art'",
      "require 'jruby_art/app'",
      BLANK,
      'Processing::App::SKETCH_PATH = __FILE__.freeze',
      BLANK
    ]
    lines.concat class_methods(param)
    lines << BLANK
    lines << format('%s.new unless defined? $app', param.class_name)
  end
end
