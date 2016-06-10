# frozen_string_literal: false
# Utility to find sketchbook and hence java libraries
module Sketchbook
  def self.find_path
    preferences_paths = []
    sketchbook_paths = []
    sketchbook_path = Processing::RP_CONFIG.fetch('sketchbook_path', false)
    return sketchbook_path if sketchbook_path
    [
      "'Application Data/Processing'", 'AppData/Roaming/Processing',
      'Library/Processing', 'Documents/Processing',
      '.processing', 'sketchbook'
    ].each do |prefix|
      spath = format('%s/%s', ENV['HOME'], prefix)
      pref_path = format('%s/preferences.txt', spath)
      preferences_paths << pref_path if FileTest.file?(pref_path)
      sketchbook_paths << spath if FileTest.directory?(spath)
    end
    return sketchbook_paths.first if preferences_paths.empty?
    lines = IO.readlines(preferences_paths.first)
    matchedline = lines.grep(/^sketchbook/).first
    matchedline[/=(.+)/].delete('=')
  end
end
