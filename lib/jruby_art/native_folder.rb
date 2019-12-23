# frozen_string_literal: true

require 'rbconfig'

# Utility to load native binaries on Java CLASSPATH
# HACK until jruby returns a more specific 'host_os' than 'linux'
class NativeFolder
  attr_reader :os, :bit

  LINUX_FORMAT = 'linux%d'
  # ARM64 = '-aarch64'
  WIN_FORMAT = 'windows%d'
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
    @bit = java.lang.System.get_property('os.arch') =~ /64/ ? 64 : 32
  end

  def name
    return 'macosx' if /darwin|mac/.match?(os)

    if /linux/.match?(os)
      return format(LINUX_FORMAT, bit)
    end
    if WIN_PATTERNS.any? { |pat| pat =~ os }
      return format(WIN_FORMAT, bit)
    end
    raise 'Unsupported Architecture'
  end

  def extension
    return '*.so' if /linux/.match?(os)
    return '*.dll' if WIN_PATTERNS.any? { |pat| pat =~ os }

    '*.dylib' # MacOS
  end
end
