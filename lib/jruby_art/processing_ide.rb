# frozen_string_literal: true

# detects processing preferences.txt, extracts sketchbook_path
class ProcessingIde
  THREE='sketchbook.path.three='.freeze
  FOUR='sketchbook.path.four='.freeze
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
        return line.tap { |sli| sli.slice!(FOUR) }.chomp if /sketchbook.path.four/.match?(line)

        return line.tap { |sli| sli.slice!(THREE) }.chomp if /sketchbook.path.three/.match?(line)
      end
    end
  end
end
