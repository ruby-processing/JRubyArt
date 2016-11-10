# frozen_string_literal: true
require_relative '../jruby_art/jruby_complete'
require_relative '../jruby_art/java_opts'
module Processing
  # This is class wrapper for building the command
  class Command
    attr_reader :executable, :runner, :args, :filename
    def initialize(executable:, runner:, args:, filename:)
      @executable = executable
      @runner = runner
      @args = args
      @filename = filename
    end

    def cmd(root)
      if executable =~ /jruby/
        cmda = [executable, JRubyOpts.new(root).opts, runner, filename, args].flatten
      else
        cmda = [executable, JavaOpts.new(root).opts, '-cp', JRubyComplete.complete, 'org.jruby.Main', runner, filename, args].flatten
      end
      begin
        # exec(*command)
        exec(*cmda)
        # exec replaces the Ruby process with the JRuby one.
      rescue Java::JavaLang::ClassNotFoundException
      end
    end
  end
end
