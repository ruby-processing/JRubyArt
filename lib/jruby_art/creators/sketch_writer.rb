# frozen_string_literal: false
# SketchParamters class
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

# The file writer knows different types
class SketchWriter
  attr_reader :file, :sketch, :param

  def initialize(path, args)
    @param = SketchParameters.new(name: path, args: args)
    @file = format('%s/%s.rb', File.dirname(path), path)
  end

  def create!(type)
    case type
    when /bare/
      @sketch = Sketch.new.bare(param)
    when /class/
      @sketch = Sketch.new.class_wrapped(param)
    when /emacs/
      @sketch = Sketch.new.emacs(param)
    end
    save(sketch)
  end

  def save(sketch)
    File.open(file, 'w+') { |f| f.write sketch.join("\n") }
  end
end

# The sketch class creates an array of formatted sketch lines
class Sketch
  def bare(param)
    lines = []
    lines.concat method_lines('settings', param.sketch_size, '')
    lines.concat method_lines('setup', param.sketch_title, '')
    lines.concat method_lines('draw', '', '')
  end

  def wrapped(param)
    lines = []
    class_name = param.name.split('_').collect(&:capitalize).join
    lines << format('class %s < Processing::App', class_name)
    lines.concat method_lines('settings', param.sketch_size, '  ')
    lines.concat method_lines('setup', param.sketch_title, '  ')
    lines.concat method_lines('draw', '', '  ')
    lines << 'end'
  end

  def class_wrapped(param)
    lines = [
      '# frozen_string_literal: false',
      ''
    ]
    lines.concat wrapped(param)
  end

  def emacs(param)
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

  private

  def method_lines(name, content, indent)
    one = format('%sdef %s', indent, name)
    two = content.empty? ? '' : format('  %s%s', indent, content)
    three = format('%send', indent)
    return [one, two, three] if /draw/ =~ name
    [one, two, three, '']
  end
end
