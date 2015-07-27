# An pry shell for live coding.
# Will start with your sketch.

require_relative 'base'
Processing.load_and_run_sketch

ARGV.clear # So that pry doesn't try to load them as files.

require 'pry'
$app.pry
