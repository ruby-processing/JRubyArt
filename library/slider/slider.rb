# encoding: utf-8
# frozen_string_literal: true
# Here's a little library for quickly hooking up in sketch sliders.
# Copyright (c) 2016 Martin Prout.

java_import 'monkstone.slider.SliderBar'

module Slider
  def self.slider(app:, x:, y:, name:, **opts)
    options = default.merge opts
    slider = SliderBar.new(
      app,
      x,
      y,
      options[:length],
      options[:range].first,
      options[:range].last,
      name
      )
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