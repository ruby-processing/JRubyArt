# frozen_string_literal: false
require 'yaml'

VERSION = '3.1.1' # processing version

class Installer
  attr_reader :os, :jruby, :sketch, :gem_root
  def initialize(os: :linux, jruby: true, root:)
    @os = os
    @jruby = jruby
    @gem_root = root
    @sketch = "#{ENV['HOME']}/sketchbook" if os == :linux
    @sketch = "#{ENV['HOME']}/My Documents/Processing" if os == :windows
    @sketch = "#{ENV['HOME']}/Documents/Processing" if os == :mac
  end

  def install
    system "cd #{gem_root}/vendors && rake"
    return if root_exist?
    set_processing_root
    warn 'PROCESSING_ROOT set optimistically, run check to confirm'
  end

  def install_examples
    system "cd #{gem_root}/vendors && rake unpack_samples"
  end

  # Optimistically set processing root
  def set_processing_root
    require 'psych'
    folder = File.expand_path("#{ENV['HOME']}/.jruby_art")
    Dir.mkdir(folder) unless File.exist? folder
    path = File.join(folder, 'config.yml')
    proot = "#{ENV['HOME']}/processing-#{VERSION}"
    proot = "/Java/Processing-#{VERSION}" if os == :windows
    proot = "/Applications/Processing.app/Contents/Java" if os == :mac
    data = {
      'PROCESSING_ROOT' => proot,
      'JRUBY' => jruby.to_s,
      'sketchbook_path' => sketch,
      'MAX_WATCH' => '20'
    }
    open(path, 'w:UTF-8') { |f| f.write(data.to_yaml) }
  end

  def root_exist?
    return false if config.nil?
    File.exist? config['PROCESSING_ROOT']
  end

  def config
    k9config = File.expand_path("#{ENV['HOME']}/.jruby_art/config.yml")
    return nil unless File.exist? k9config
    YAML.load_file(k9config)
  end

  def check
    show_version
    installed = File.exist? File.join(gem_root, 'lib/ruby/jruby-complete.jar')
    proot = '  PROCESSING_ROOT = Not Set!!!' unless root_exist?
    proot ||= "  PROCESSING_ROOT = #{config['PROCESSING_ROOT']}"
    sketchbook = "  sketchbook_path = #{config['sketchbook_path']}"
    max_watch = "  MAX_WATCH = #{config['MAX_WATCH']}"
    jruby = config['JRUBY']
    puts proot
    puts "  JRUBY = #{jruby}" unless jruby.nil?
    puts "  jruby-complete installed = #{installed}"
    puts sketchbook
    puts max_watch
  end

  # Display the current version of JRubyArt.
  def show_version
    puts format('JRubyArt version %s', JRubyArt::VERSION)
  end
end
