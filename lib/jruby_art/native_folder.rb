# frozen_string_literal: true

require 'rbconfig'

# Utility to load native binaries on Java CLASSPATH
# HACK until jruby returns a more specific 'host_os' than 'linux'
class NativeFolder
  attr_reader :os, :bit

  LINUX_FORMAT = 'linux%<bit>d'
  # ARM64 = '-aarch64'
  WIN_FORMAT = 'windows%<bit>d'
  WIN_PATTERNS = [
    /bccwin/i,
    /cygwin/i,
    /djgpp/i,
    /ming/i,
    /mswin/i,
    /wince/i
  ].freeze

  def initialize
    @os = RbConfig::CONFIG['host_os'].downcase
    @bit = /64/.match?(java.lang.System.get_property('os.arch')) ? 64 : 32
  end

  def name
    return macos if /darwin|mac/.match?(os)

    return format(LINUX_FORMAT, bit: bit) if /linux/.match?(os)

    unless WIN_PATTERNS.any? { |pat| pat.match?(os) }
      raise StandardError, 'Unsupported Architecture'
    end

    format(WIN_FORMAT, bit: bit)
  end

  def extension
    return '*.so' if /linux/.match?(os)

    return '*.dll' if WIN_PATTERNS.any? { |pat| pat.match?(os) }

    '*.dylib' # MacOS
  end
end
