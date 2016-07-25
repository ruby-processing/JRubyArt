# frozen_string_literal: false
# Sketch class
class SketchWriter
  attr_reader :file, :args, :sketch, :name

  def initialize(path, args)
    @args = args
    @name = path
    @file = format('%s/%s.rb', File.dirname(path), path)
  end

  def create!(type)
    case type
    when /bare/
      @sketch = Sketch.new.bare(name, args)
    when /class/
      @sketch = Sketch.new.class_wrapped(name, args)
    when /emacs/
      @sketch = Sketch.new.emacs(name, args)
    end
    save(sketch)
  end

  def save(sketch)
    File.open(file, 'w+') { |f| f.write sketch.join("\n") }
  end
end

# The sketch class creates an array of formatted sketch lines
class Sketch
  def bare(name, args)
    mode = args.length == 3 ? format(', %s', args[2].upcase) : ''
    size = args.empty? ? 'size 200, 200' : format('size %d, %d%s', args[0].to_i, args[1].to_i, mode)
    lines = []
    lines.concat method_lines('settings', size, '')
    sketch_title = name.split('_').collect(&:capitalize).join(' ')
    lines.concat method_lines('setup', format("sketch_title '%s'", sketch_title), '')
    lines.concat last_method('draw', '', '')
  end

  def wrapped(name, args)
    mode = args.length == 3 ? format(', %s', args[2].upcase) : ''
    size = args.empty? ? 'size 200, 200' : format('size %d, %d%s', args[0].to_i, args[1].to_i, mode)
    lines = []
    class_name = name.split('_').collect(&:capitalize).join
    lines << format('class %s < Processing::App', class_name)
    lines.concat method_lines('settings', size, '  ')
    sketch_title = name.split('_').collect(&:capitalize).join(' ')
    lines.concat method_lines('setup', format("sketch_title '%s'", sketch_title), '  ')
    lines.concat last_method('draw', '', '  ')
    lines << 'end'
  end

  def class_wrapped(name, args)
    lines = []
    lines << '# frozen_string_literal: false'
    lines << ''
    lines.concat wrapped(name, args)
  end

  def emacs(name, args)
    lines = []
    lines << '# frozen_string_literal: false'
    lines << "require 'jruby_art'"
    lines << "require 'jruby_art/app'"
    lines << ''
    lines << 'Processing::App::SKETCH_PATH = __FILE__.freeze'
    lines << ''
    class_name = name.split('_').collect(&:capitalize).join
    lines.concat wrapped(name, args)
    lines << ''
    lines << format('%s.new unless defined? $app', class_name)
  end

  private

  def last_method(name, content, indent)
    one = format('%sdef %s', indent, name)
    two = content.empty? ? '' : format('  %s%s', indent, content)
    three = format('%send', indent)
    [one, two, three]
  end

  def method_lines(name, content, indent)
    last_method(name, content, indent) << ''
  end
end
