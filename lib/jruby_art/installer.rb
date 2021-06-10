# frozen_string_literal: true

require_relative 'config'
require_relative 'processing_ide'

class Installer
  attr_reader :processing_ide
  def initialize
    @processing_ide = ProcessingIde.new
  end

  def install
    config = if processing_ide.installed?
               Config.new(
                 'processing_ide' => true,
                 'library_path' => processing_ide.sketchbook_path
               )
             else
               Config.new('processing_ide' => false)
             end
    config.write_to_file
  end
end

# Examples Installer
class UnpackSamples
  def install
    system "cd #{K9_ROOT}/vendors && rake unpack_samples"
  end
end

# JRuby-Complete installer
class JRubyCompleteInstall
  def install
    system "cd #{K9_ROOT}/vendors && rake"
  end
end
