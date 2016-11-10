# frozen_string_literal: true
require_relative '../jruby_art/jruby_complete'
require_relative '../jruby_art/java_opts'
module Processing
  class Command
    attr_reader :executable, :runner, :args, :filename
    def initialize(executable:, runner:, args:, filename:)
      @executable = executable
      @runner = runner
      @args = args
      @filename = filename
    end

    def cmd(root)
      return [executable, JRubyOpts.new(root).opts, runner, filename, args].flatten if executable =~ /jruby/
      [executable, JavaOpts.new(root).opts, '-cp', JRubyComplete.complete, 'org.jruby.Main', runner, filename, args].flatten
    end
  end
end
