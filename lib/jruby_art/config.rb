require 'yaml'
require_relative 'default_config'
require_relative 'version'
HOME = ENV['HOME']
# Configuration class
class Config
  attr_reader :config
  def initialize(conf = {})
    @config = Default.config.merge(conf)
  end

  def write_to_file
    directory = File.join(HOME, '.jruby_art')
    Dir.mkdir(directory) unless Dir.exist? directory
    File.write(File.join(HOME, '.jruby_art', 'config.yml'), config.to_yaml)
  end

  def load_config
    config_path = File.join(File.join(HOME, '.jruby_art', 'config.yml'))
    if File.exist? config_path
      loaded = YAML.safe_load(File.read(config_path))
      @config = Default.config.merge(loaded)
      return self unless loaded.key? 'PROCESSING_ROOT'

      warn '*********** Move Old Config File ***************'
    end
    @config = Default.config
    warn '*********** Default Config Loaded ***************'
    self
  end

  def check
    load_config
    puts "JRubyArt version #{JRubyArt::VERSION}"
    puts 'Approximates to Processing-4.0'
    puts "processing ide = #{config.fetch('processing_ide', false)}"
    puts "library_path = #{config.fetch('library_path', File.join(HOME, '.jruby_art'))}"
    puts "template = #{config.fetch('template', 'bare')}"
    puts "java_args = #{config.fetch('java_args', '')}"
    puts "MAX_WATCH = #{config.fetch('MAX_WATCH', 32)}"
    puts "JRUBY = #{config.fetch('JRUBY', true)}"
  end
end
