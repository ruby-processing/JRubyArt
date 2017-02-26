# frozen_string_literal: true
# module encapsulates a check that the PROCESSING_ROOT exists
module Core
  def self.check?(path)
    if File.directory?(path)
      core_path = File.join(path, 'core/library/core.jar')
      return true if File.exist?(core_path)
      warn format('%s jar does not exist', core_path)
    else warn format('%s directory does not exist', path)
    end
  end
end

# Provided processing distributions have the same nested structure ie:-
# "core/library/core.jar" we can find "core.jar" when PROCESSING_ROOT exists
