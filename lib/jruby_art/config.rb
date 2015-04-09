require 'yaml'
# The Processing module is a wrapper for JRubyArt
# Author:: Martin Prout (extends / re-implements ruby-processing)
module Processing
  unless defined? RP_CONFIG
    begin
      CONFIG_FILE_PATH = File.expand_path('~/.jruby_art/config.yml')
      RP_CONFIG = YAML.load_file(yaml)
    rescue
      warn('WARNING: you need to set PROCESSING_ROOT in ~/.jruby_art/config.yml')
    end
  end
end



