# frozen_string_literal: true
require_relative '../jruby_art/jruby_complete'
require_relative '../jruby_art/java_opts'
module Processing
  # The command class check for configuration and options, before creating and
  # executing the jruby (or java) command to run the sketch
  class Launcher
    attr_reader :runner, :args, :filename
    def initialize(runner:, args:, filename:)
      @runner = runner
      @args = args
      @filename = filename
    end

    # Trade in this Ruby instance for a JRuby instance, loading in a starter
    # script and passing it some arguments. Unless you set JRUBY: false in
    # ~/.jruby_art/config.yml, an installed version of jruby is used instead
    # of our vendored one. Note the use of jruby-complete might make using
    # other gems in your sketches hard (but not impossible)....
    def cmd
      cmda = jruby_command
      begin
        exec(*cmda)
        # exec replaces the Ruby process with the JRuby one.
      rescue Java::JavaLang::ClassNotFoundException
      end
    end

    private

    # avoiding multiline ternary etc
    def jruby_command
      installed = Processing::RP_CONFIG.fetch('JRUBY', true)
      opts = installed ? JRubyOpts.new.opts : JavaOpts.new.opts
      return ['jruby', opts, runner, filename, args].flatten if installed
      complete = JRubyComplete.complete
      ['java', opts, '-cp', complete, 'org.jruby.Main', runner, filename, args].flatten
    end
  end
end
