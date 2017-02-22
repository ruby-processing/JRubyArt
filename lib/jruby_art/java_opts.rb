# frozen_string_literal: false
# class to parse java_args.txt or java_args in config.yml
class JavaOpts
  attr_reader :opts

  def initialize
    arg_file = File.join(SKETCH_ROOT, 'data/java_args.txt')
    @opts = []
    @opts += File.read(arg_file).split(/\s+/) if FileTest.exist?(arg_file)
    return unless opts.empty? && Processing::RP_CONFIG.fetch('java_args', false)
    @opts += Processing::RP_CONFIG['java_args'].split(/\s+/)
  end
end

# wrap args to pass through to jvm from jruby
class JRubyOpts < JavaOpts
  def opts
    super.map { |arg| "-J#{arg}" }
  end
end
