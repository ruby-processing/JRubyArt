require 'rbconfig'

# Utility to load native binaries on Java CLASSPATH
# HACK until jruby returns a more specific 'host_os' than 'linux'
class NativeFolder
  attr_reader :os, :bit

  LINUX_FORMAT = 'linux%s'.freeze
  ARM32 = '-armv6hf'.freeze
  # ARM64 = '-aarch64'.freeze
  WIN_FORMAT = 'windows%d'.freeze
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
    return 'macosx' if /darwin|mac/.match?(os)
    if /linux/.match?(os)
      return format(LINUX_FORMAT, '64') if /amd64/.match?(bit)
      return format(LINUX_FORMAT, ARM32) if /arm/.match?(bit)
    end
    if WIN_PATTERNS.any? { |pat| pat =~ os }
      return format(WINDOWS_FORMAT, '64') if /64/.match?(bit)
      return format(WINDOWS_FORMAT, '32') if /32/.match?(bit)
    end
    raise 'Unsupported Architecture'
  end

  def extension
    return '*.so' if /linux/.match?(os)
    return '*.dll' if WIN_PATTERNS.any? { |pat| pat =~ os }
    '*.dylib' # MacOS
  end
end
