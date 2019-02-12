# frozen_string_literal: false

require 'yaml'
VERSION = '3.5.3'.freeze # processing version
HOME = ENV['HOME']
# Abstract Installer class
class Installer
  attr_reader :os, :sketch, :gem_root, :confd
  def initialize(root, os)
    @os = os
    @gem_root = root
    @sketch = "#{HOME}/sketchbook" if os == :linux
    @sketch = "#{HOME}/My Documents/Processing" if os == :windows
    @sketch = "#{HOME}/Documents/Processing" if os == :mac
    @confd = "#{HOME}/.jruby_art"
  end

  # Optimistically set processing root
  def set_processing_root
    folder = "#{HOME}/.jruby_art"
    Dir.mkdir(folder) unless File.exist? folder
    path = File.join(folder, 'config.yml')
    proot = "#{HOME}/processing-#{VERSION}"
    proot = "/usr/local/lib/processing-#{VERSION}" if os == :arm
    proot = "/Java/Processing-#{VERSION}" if os == :windows
    proot = '/Applications/Processing.app/Contents/Java' if os == :mac
    jruby = true
    jruby = false if os == :arm
    settings = %w[
      PROCESSING_ROOT JRUBY sketchbook_path template MAX_WATCH sketch_title width height
    ]
    values = [
      proot, true, sketch, 'bare', 32, 'JRubyArt Static Sketch', 600, 600
    ]
    data = settings.zip(values).to_h
    open(path, 'w:UTF-8') { |file| file.write(data.to_yaml) }
    warn 'PROCESSING_ROOT set optimistically, run check to confirm'
  end

  def root_exist?
    Core.check?(config['PROCESSING_ROOT'])
  end

  def config
    k9config = File.join(confd, 'config.yml')
    return '' unless File.exist? k9config
    YAML.load_file(k9config)
  end

  # in place of default installer class
  def install
    puts 'Usage: k9 [--check | --install | --help]'
  end

  # Display the current version of JRubyArt.
  def show_version
    puts format('JRubyArt version %s', JRubyArt::VERSION)
    puts format('Expected Processing version %s', VERSION)
  end
end

# Configuration checker
class Check < Installer
  require_relative './core'
  def install
    show_version
    return super unless config
    installed = File.exist? File.join(gem_root, 'lib/ruby/jruby-complete.jar')
    proot = '  PROCESSING_ROOT = Not Set Correctly!!!' unless root_exist?
    proot ||= "  PROCESSING_ROOT = #{config['PROCESSING_ROOT']}"
    sketchbook = "  sketchbook_path = #{config['sketchbook_path']}"
    template = "  template = #{config['template']}"
    java_args = "  java_args = #{config['java_args']}"
    max_watch = "  MAX_WATCH = #{config['MAX_WATCH']}"
    jruby = config.fetch('JRUBY', true)
    puts proot
    puts "  JRUBY = #{jruby}" unless jruby.nil?
    puts "  jruby-complete installed = #{installed}"
    puts sketchbook
    puts template
    puts java_args
    puts max_watch
  end
end

# Examples Installer
class UnpackSamples < Installer
  def install
    system "cd #{gem_root}/vendors && rake unpack_samples"
  end
end

# JRuby-Complete installer
class JRubyCompleteInstall < Installer
  def install
    set_processing_root unless File.exist? File.join(confd, 'config.yml')
    system "cd #{gem_root}/vendors && rake"
  end
end
