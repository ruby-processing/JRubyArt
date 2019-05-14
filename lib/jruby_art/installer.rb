require_relative 'config'
require_relative 'processing_ide'

class Installer
  attr_reader :processing_ide
  def initialize
    @processing_ide = ProcessingIde.new
  end

  def install
    if processing_ide.installed?
      config = Config.new(
        'processing_ide' => true,
        'library_path' => processing_ide.sketchbook_path)
    else
      config = Config.new('processing_ide' => false)
    end
    config.write_to_file
  end
end
