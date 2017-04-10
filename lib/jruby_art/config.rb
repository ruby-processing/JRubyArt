# frozen_string_literal: false

require 'yaml'

# The wrapper module
module Processing
  unless defined? RP_CONFIG
    config_path = '~/.jruby_art/config.yml'
    begin
      CONFIG_FILE_PATH = File.expand_path(config_path)
      RP_CONFIG = YAML.load_file(CONFIG_FILE_PATH)
    rescue
      warn(format('WARN: you need to set PROCESSING_ROOT in %s', config_path))
    end
  end

  WIN_PATTERNS = [
    /bccwin/i,
    /cygwin/i,
    /djgpp/i,
    /ming/i,
    /mswin/i,
    /wince/i
  ].freeze

  # This class knows about supported JRubyArt operating systems
  class HostOS
    def self.os
      detect_os = RbConfig::CONFIG['host_os']
      case detect_os
      when /mac|darwin/ then :mac
      when /linux/ then :linux
      when *WIN_PATTERNS then :windows
      else
        raise "unsupported os: #{detect_os.inspect}"
      end
    end
  end
  OS ||= HostOS.os
end

# This class encapulates knowledge of processing sketchbook structure
class Sketchbook
  def self.path
    File.join(Processing::RP_CONFIG['sketchbook_path'], 'libraries')
  end

  def self.library(name)
    Dir["#{path}/#{name}/library/\*.jar"]
  end
end

# Expected vanilla processing paths for a given library name
class ProcessingPath
  def self.list(name)
    [
      "#{SKETCH_ROOT}/library/#{name}",
      "#{Processing::RP_CONFIG['PROCESSING_ROOT']}/modes/java/libraries/#{name}/library",
      "#{K9_ROOT}/library/#{name}/library",
      "#{K9_ROOT}/library/#{name}",
      "#{Sketchbook.path}/#{name}/library"
    ]
  end
end
