# frozen_string_literal: false

require 'optparse'
require 'fileutils'
require 'rbconfig'
require_relative '../jruby_art/config'
require_relative '../jruby_art/version'
require_relative '../jruby_art/java_opts'
require_relative '../jruby_art/launcher'
# processing wrapper module
module Processing
  # Utility class to handle the different commands that the 'k9' command
  # offers. Able to run, watch, live, create, app, and unpack
  class Runner
    WIN_PATTERNS = [
      /bccwin/i,
      /cygwin/i,
      /djgpp/i,
      /ming/i,
      /mswin/i,
      /wince/i
    ].freeze

    attr_reader :options, :argc, :filename, :os

    def initialize
      @options = {}
    end

    # Start running a jruby_art filename from the passed-in arguments
    def self.execute
      runner = new
      runner.parse_options(ARGV)
      runner.execute!
    end

    # Dispatch central.
    def execute!
      show_help if options.empty?
      show_version if options[:version]
      run_sketch if options[:run]
      watch_sketch if options[:watch]
      live if options[:live]
      create if options[:create]
      check if options[:check]
      install if options[:install]
    end

    # Parse the command-line options.
    def parse_options(args)
      opt_parser = OptionParser.new do |opts|
        # Set a banner, displayed at the top
        # of the help screen.
        opts.banner = 'Usage: k9 [options] [<filename.rb>]'
        # Define the options, and what they do
        options[:version] = false
        opts.on('-v', '--version', 'JRubyArt Version') do
          options[:version] = true
        end

        options[:install] = false
        opts.on('-i', '--install', 'Installs jruby-complete and examples') do
          options[:install] = true
        end

        options[:check] = false
        opts.on('-?', '--check', 'Prints configuration') do
          options[:check] = true
        end

        options[:app] = false
        opts.on('-a', '--app', 'Export as app NOT IMPLEMENTED YET') do
          options[:export] = true
        end

        options[:watch] = false
        opts.on('-w', '--watch', 'Watch/run the sketch') do
          options[:watch] = true
        end

        options[:run] = false
        opts.on('-r', '--run', 'Run the sketch') do
          options[:run] = true
        end

        options[:live] = false
        opts.on('-l', '--live', 'As above, with pry console bound to Processing.app') do
          options[:live] = true
        end

        options[:create] = false
        opts.on('-c', '--create', 'Create new outline sketch') do
          options[:create] = true
        end

        # This displays the help screen, all programs are
        # assumed to have this option.
        opts.on('-h', '--help', 'Display this screen') do
          puts opts
          exit
        end
      end
      @argc = opt_parser.parse(args)
      @filename = argc.shift
    end

    def create
      require_relative '../jruby_art/creators/sketch_writer'
      SketchWriter.new(File.basename(filename, '.rb'), argc).write
    end

    # Export as app not implemented
    def export
      ensure_exists(filename)
      puts 'Not implemented yet'
    end

    # Just simply run a JRubyArt filename.
    def run_sketch
      ensure_exists(filename)
      spin_up('run.rb', filename, argc)
    end

    # Just simply run a JRubyArt filename.
    def live
      ensure_exists(filename)
      spin_up('live.rb', filename, argc)
    end

    # Run a filename, keeping an eye on it's file, and reloading
    # whenever it changes.
    def watch_sketch
      ensure_exists(filename)
      spin_up('watch.rb', filename, argc)
    end

    def install
      require_relative '../jruby_art/installer'
      JRubyCompleteInstall.new(K9_ROOT, OS).install
      UnpackSamples.new(K9_ROOT, OS).install
    end

    def check
      require_relative '../jruby_art/installer'
      Check.new(K9_ROOT, OS).install
    end

    # Show the standard help/usage message.
    def show_help
      puts HELP_MESSAGE
    end

    def show_version
      require 'erb'
      warning = 'WARNING: JDK8 is preferred'.freeze
      if RUBY_PLATFORM == 'java'
        warn warning unless ENV_JAVA['java.specification.version'] == '1.8'
      end
      template = ERB.new <<-EOF
        JRubyArt version <%= JRubyArt::VERSION %>
        Ruby version <%= RUBY_VERSION %>
      EOF
      puts template.result(binding)
    end

    private

    # We now build and execute the command arguments in the Launcher class.
    # Here we only need to supply the starter script, filename and args if any,
    # the Launcher class checks config (is executable java or jruby?)
    # and for any options in java_args.txt or config
    def spin_up(starter_script, filename, argc)
      launch = Launcher.new(
        runner: "#{K9_ROOT}/lib/jruby_art/runners/#{starter_script}",
        args: argc,
        filename: filename
      )
      launch.cmd
    end

    # NB: We really do mean to use 'and' not '&&' for flow control purposes

    def ensure_exists(filename)
      puts("Couldn't find: #{filename}") and exit unless FileTest.exist?(filename)
    end

    def jruby_complete
      rcomplete = File.join(K9_ROOT, 'lib/ruby/jruby-complete.jar')
      return [rcomplete] if FileTest.exist?(rcomplete)
      warn "#{rcomplete} does not exist\nTry running `k9 --install`"
      exit
    end

    def libraries
      %w(video sound).map { |library| Sketchbook.library(library) }.flatten
    end
  end # class Runner
end # module Processing
