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
    @bit = java.lang.System.get_property('os.arch')
  end

  def name
    return 'macosx' if os =~ /darwin/ || os =~ /mac/
    return format(WIN_FORMAT, bit) if WIN_PATTERNS.any? { |pat| pat.match?(os) }
    return format(LINUX_FORMAT, bit) if /linux/.match?(os)
  end

  def extension
    return '*.so' if os =~ /linux/
    return '*.dll' if WIN_PATTERNS.any? { |pat| pat.match?(os) }
    '*.dylib' # MacOS
  end
end
