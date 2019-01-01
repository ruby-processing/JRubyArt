# frozen_string_literal: true
# Here's a little library for quickly hooking up in sketch sliders.
# Copyright (c) 2016-19 Martin Prout.

java_import 'monkstone.slider.CustomHorizontalSlider'
java_import 'monkstone.slider.CustomVerticalSlider'

module Slider
  def self.slider(app:, x:, y:, name:, **opts)
    options = default.merge opts
    if options[:vertical]
      slider = CustomVerticalSlider.new(
        app,
        x,
        y,
        options[:length],
        options[:range].first,
        options[:range].last,
        name
    )
    else
      slider = CustomHorizontalSlider.new(
        app,
        x,
        y,
        options[:length],
        options[:range].first,
        options[:range].last,
        name
    )
    end
    unless opts.empty?
      slider.bar_width(opts.fetch(:bar_width, 10))
      slider.set_value(opts.fetch(:initial_value, 0))
    end
    slider
  end
  
  def self.default
    { length: 100, range: (0..100) }
  end
end
