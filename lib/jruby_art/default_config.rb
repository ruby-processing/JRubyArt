# frozen_string_literal: true

# default configuration
class Default
  def self.config
    {
      'processing_ide' => false,
      'library_path' => File.join(ENV['HOME'], '.jruby_art', 'libraries'),
      'MAX_WATCH' => 32,
      'JRUBY' => true,
      'template' => 'bare',
      'java_args' => nil
    }
  end
end
