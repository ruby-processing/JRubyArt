# encoding: utf-8
# frozen_string_literal: false

require 'yaml'

# The wrapper module
module Processing
  unless defined? RP_CONFIG
    config_path = '~/.jruby_art/config.yml'
    begin
      CONFIG_FILE_PATH = File.expand_path(config_path)
      RP_CONFIG = (YAML.load_file(CONFIG_FILE_PATH))
    rescue
      warn(format('WARN: you need to set PROCESSING_ROOT in %s', config_path))
    end
  end
end
