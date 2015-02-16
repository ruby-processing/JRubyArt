CLASS_BASIC = <<-CODE
require 'jruby_art'

class %s < Processing::App
  def setup
    size %s, %s
  end

  def draw

  end
end

%s.new(title: '%s')
CODE

CLASS_MODE = <<-CODE
require 'jruby_art'

class %s < Processing::AppGL
  def setup
    size %s, %s, %s
  end

  def draw

  end
end

%s.new(title: '%s')
CODE

module Processing
  require_relative '../jruby_art/helpers/string_extra'
  require_relative '../jruby_art/helpers/camel_string'
  # Write file to disk
  class SketchWriter
    attr_reader :file
    def initialize(path)
      underscore = StringExtra.new(path).underscore
      @file = "#{File.dirname(path)}/#{underscore}.rb"
    end

    def save(template)
      File.open(file, 'w+') do |f|
        f.write(template)
      end
    end
  end

  # An abstract class providing common methods for real creators
  class Creator
    ALL_DIGITS = /\A\d+\Z/

    def already_exist(path)
      underscore = StringExtra.new(path).underscore
      new_file = "#{File.dirname(path)}/#{underscore}.rb"
      return if !FileTest.exist?(path) && !FileTest.exist?(new_file)
      puts 'That file already exists!'
      exit
    end

    # Show the help/usage message for create.
    def usage
      puts <<-USAGE

      Usage: k9 create <sketch_to_generate> <width> <height>
      Examples: k9 create my_app 800 600
                k9 create my_app 800 600 p3d

      USAGE
    end
  end

  # This class creates class wrapped sketches, with an optional render mode
  class ClassSketch < Creator
    def class_template
      format(CLASS_BASIC, @name, @width, @height, @name, @title)
    end

    def class_template_mode
      format(CLASS_MODE, @name, @width, @height, @mode, @name, @title)
    end

    # Create a bare blank sketch, given a path.
    def create!(path, args)
      return usage if /\?/ =~ path || /--help/ =~ path
      main_file = File.basename(path, '.rb') # allow uneeded extension input
      # Check to make sure that the main file doesn't exist already
      already_exist(path)
      @name = CamelString.new(main_file).camelize
      writer = SketchWriter.new(main_file)
      @title = StringExtra.new(main_file).titleize
      @width, @height = args[0], args[1]
      @mode = args[2].upcase unless args[2].nil?
      template = @mode.nil? ? class_template : class_template_mode
      writer.save(template)
    end
  end
end
