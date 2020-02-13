# frozen_string_literal: true

# detects processing preferences.txt, extracts sketchbook_path
class ProcessingIde
  attr_reader :preferences
  def initialize
    @preferences = File.join(ENV['HOME'], '.processing', 'preferences.txt')
  end

  def installed?
    File.exist?(preferences)
  end

  def sketchbook_path
    File.open(preferences, 'r') do |file|
      file.each_line do |line|
        return line.tap { |sli| sli.slice!('sketchbook.path.three=') }.chomp if line =~ /sketchbook/
      end
    end
  end
end
