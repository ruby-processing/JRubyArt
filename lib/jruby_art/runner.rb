require 'ostruct'
require 'fileutils'
require 'rbconfig'
#require_relative '../jruby_art/config'
require_relative '../jruby_art/version'


module Processing

  # Utility class to handle the different commands that the 'rp5' command
  # offers. Able to run, watch, live, create, app, and unpack
  class Runner
    HELP_MESSAGE = <<-EOS
    JRubyArt Version: #{JRubyArt::VERSION}
    
    JRubyArt is a little shim between Processing and JRuby that helps
    you create sketches of code art.

    Usage:
    k9  create some_new_sketch 640 480
    jruby some_new_sketch.rb
    @todo  Allow a covenient way of running sketches with jruby-complete
    
    .......k9 run some_new_sketch.rb    
    EOS
    
    WIN_PATTERNS = [
      /bccwin/i,
      /cygwin/i,
      /djgpp/i,
      /mingw/i,
      /mswin/i,
      /wince/i
    ]
    
    attr_reader :os

    # Start running a ruby-processing sketch from the passed-in arguments
    def self.execute
      runner = new
      runner.parse_options(ARGV)
      runner.execute!
    end

    # Dispatch central.
    def execute!
      case @options.action
      when 'run'    then run(@options.path, @options.args)
      when 'watch'  then watch(@options.path, @options.args)
      when 'live'   then live(@options.path, @options.args)
      when 'create' then create(@options.path, @options.args)
      when 'app'    then app(@options.path)
      when 'setup'  then setup(@options.path)
      when /-v/     then show_version
      when /-h/     then show_help
      else
        show_help
      end
    end

    # Parse the command-line options. Keep it simple.
    def parse_options(args)
      @options = OpenStruct.new
      @options.wrap = !args.delete('--wrap').nil?
      @options.inner = !args.delete('--inner').nil?
      @options.jruby = !args.delete('--jruby').nil?
      @options.nojruby = !args.delete('--nojruby').nil?
      @options.action = args[0] || nil
      @options.path = args[1] || File.basename(Dir.pwd + '.rb')
      @options.args = args[2..-1] || []
    end

    # Create a fresh Ruby-Processing sketch, with the necessary
    # boilerplate filled out.
    def create(sketch, args)
      require_relative 'creator'
      Processing::ClassSketch.new.create!(sketch, args)
    end
    
    # Show the standard help/usage message.
    def show_help
      puts HELP_MESSAGE
    end
  end
end
