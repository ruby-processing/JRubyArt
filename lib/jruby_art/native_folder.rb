require 'rbconfig'

# Utility to load native binaries on Java CLASSPATH
class NativeFolder
  attr_reader :os, :bit

  WIN_FORMAT = 'windows%s'.freeze
  LINUX_FORMAT = 'linux%s'.freeze
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
    @bit = /64/.match?(java.lang.System.get_property('os.arch')) ? '64' : '32'
  end

  def name
    return 'macosx' if /darwin|mac/.match?(os)
    return format(WIN_FORMAT, bit) if WIN_PATTERNS.any? { |pat| pat.match?(os) }
    format(LINUX_FORMAT, bit) if /linux/.match?(os)
  end

  def extension
    return '*.so' if /linux/.match?(os)
    return '*.dll' if WIN_PATTERNS.any? { |pat| pat.match?(os) }
    '*.dylib' # MacOS
  end
end
