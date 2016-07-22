EMACS = <<-CODE
# frozen_string_literal: false
require 'jruby_art'
require 'jruby_art/app'

Processing::App::SKETCH_PATH = __FILE__.freeze

class %s < Processing::App
  def settings
    %s
  end

  def setup
    %s
  end

  def draw
  end
end

%s.new unless defined? $app

CODE

CLASS = <<-CODE
class %s < Processing::App
  def settings
    %s
  end

  def setup
    %s
  end

  def draw
  end
end

CODE

METHOD = <<-CODE
def %s
  %s
end

CODE

# require_relative '../helpers/string_extra'

# Sketch writer class
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
    File.open(file, 'w+') do |f|
      f.write(sketch)
    end
  end
end

# Sketch class
class Sketch
  def bare(name = 'sketch', args = [])
    [settings(args), setup(name), draw].join
  end

  def class_wrapped(name = 'sketch', args = [])
    class_name = name.split('_').map(&:capitalize).join('')
    format(CLASS, class_name, size(args[0].to_i, args[1].to_i, args[2]), name(name))
  end

  def emacs(name = 'sketch', args = [])
    class_name = name.split('_').map(&:capitalize).join('')
    format(
      EMACS,
      class_name,
      size(args[0].to_i, args[1].to_i, args[2]),
      name(name),
      class_name
    )
  end

  def size(width = 200, height = 200, mode = nil)
    return format('size %d, %d', width, height) if mode.nil?
    format('size %d, %d, %s', width, height, mode.upcase)
  end

  def settings(args = [])
    return format(METHOD, 'settings', size) if args.empty?
    return format(
      METHOD,
      'settings',
      size(args[0].to_i, args[1].to_i)
    ) if args.length == 2
    format(METHOD, 'settings', size(args[0].to_i, args[1].to_i, args[2]))
  end

  def name(title = 'Sketch')
    format("sketch_title '%s'", title.split('_').map(&:capitalize).join(' '))

  end

  def setup(title)
    format(METHOD, 'setup', name(title))
  end

  def draw
    format(METHOD, 'draw', '')
  end
end
