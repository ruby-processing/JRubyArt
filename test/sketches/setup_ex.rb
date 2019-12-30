# frozen_string_literal: true

def setup
  unknown_method
rescue StandardError => e
  puts e
  exit
end

def draw; end

def settings
  size(300, 300)
end
