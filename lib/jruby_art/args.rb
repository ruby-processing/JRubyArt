# frozen_string_literal: false
# class to parse java_args.txt or java_args in config.yml
class JavaArgs
  attr_reader :java

  def initialize(sketch_root)
    arg_file = File.join(sketch_root, 'data/java_args.txt')
    @java = []
    if FileTest.exist?(arg_file)
      @java += File.read(arg_file).split(/\s+/)
    elsif Processing::RP_CONFIG['java_args']
      @java += Processing::RP_CONFIG['java_args'].split(/\s+/)
    end
  end
  
  # wrap java args for jruby
  def jruby
    return [] if java.length == 0
    java.map { |arg| "-J#{arg}" }
  end
end
