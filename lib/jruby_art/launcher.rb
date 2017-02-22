# frozen_string_literal: true
require_relative '../jruby_art/jruby_complete'
require_relative '../jruby_art/java_opts'
module Processing
  # The command class check for configuration and options, before creating and
  # executing the jruby (or java) command to run the sketch
  class Launcher
    attr_reader :command
    def initialize(runner:, args:, filename:)
      @command = if Processing::RP_CONFIG.fetch('JRUBY', true)
                   JRubyCommand.new(runner, filename, args)
                 else
                   JavaCommand.new(runner, filename, args)
                 end
    end

    # Trade in this Ruby instance for a JRuby instance, loading in a starter
    # script and passing it some arguments. Unless you set JRUBY: false in
    # ~/.jruby_art/config.yml, an installed version of jruby is used instead
    # of our vendored one. Note the use of jruby-complete might make using
    # other gems in your sketches hard (but not impossible)....
    def cmd
      cmda = command.cmd
      begin
        exec(*cmda)
        # exec replaces the Ruby process with the JRuby one.
      rescue Java::JavaLang::ClassNotFoundException
      end
    end
  end
end

# Wrap creation of java command string as a class
class JavaCommand
  MAIN = 'org.jruby.Main'.freeze
  attr_reader :runner, :args, :filename, :opts, :complete
  def initialize(runner, args, filename)
    @runner, @args, @filename = runner, args, filename
    @complete = JRubyComplete.complete
    @opts = JavaOpts.new.opts
  end

  def cmd
    ['java', opts, '-cp', complete, MAIN, runner, filename, args].flatten
  end
end

# Wrap creation of jruby command string as a class
class JRubyCommand
  attr_reader :runner, :args, :filename, :opts
  def initialize(runner, args, filename)
    @runner, @args, @filename = runner, args, filename
    @opts = JRubyOpts.new.opts
  end

  def cmd
    ['jruby', opts, runner, filename, args].flatten
  end
end
