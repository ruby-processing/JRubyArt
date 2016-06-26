# frozen_string_literal: false
# class to parse java_args.txt or java_args in config.yml
class JavaOpts
  attr_reader :jvm_opts

  def initialize(sketch_root)
    arg_file = File.join(sketch_root, 'data/java_args.txt')
    @jvm_opts = []
    if FileTest.exist?(arg_file)
      @jvm_opts += File.read(arg_file).split(/\s+/)
    elsif Processing::RP_CONFIG['java_args']
      @jvm_opts += Processing::RP_CONFIG['java_args'].split(/\s+/)
    end
  end
  
  # wrap java args for jruby
  def jruby
    return [] if jvm_opts.length == 0
    jvm_opts.map { |arg| "-J#{arg}" }
  end
end
