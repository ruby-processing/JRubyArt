# An IRB/pry shell for live coding.
# Will start with your sketch.
require_relative 'base'
Processing.load_and_run_sketch

if Gem::Specification.find_all_by_name('pry').any?
  require 'pry'
  $app.pry
else
  require 'irb'

  module IRB # :nodoc:
    def self.start_session(binding)
      unless @__initialized
        args = ARGV
        ARGV.replace(ARGV.dup)
        IRB.setup(nil)
        ARGV.replace(args)
        @__initialized = true
      end
      workspace = WorkSpace.new(binding)
      irb = Irb.new(workspace)
      @CONF[:IRB_RC].call(irb.context) if @CONF[:IRB_RC]
      @CONF[:MAIN_CONTEXT] = irb.context
      catch(:IRB_EXIT) do
        irb.eval_input
      end
    end
  end
end

IRB.start_session($app)
