# frozen_string_literal: true

gem 'minitest' # don't use bundled minitest
require 'minitest/autorun'
require 'minitest/pride'
require 'jruby'
require_relative '../lib/jruby_art'
require "#{K9_ROOT}/lib/jruby_art-#{JRubyArt::VERSION}.jar"
