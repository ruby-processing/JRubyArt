# encoding: utf-8
# frozen_string_literal: false

require 'forwardable'

# String utility for creating titles and class-names
class StringExtra
  extend Forwardable
  def_delegators :@str, :upcase, :capitalize, :length, :downcase, :gsub, :tr
  def initialize(str)
    @str = str
  end

  def titleize
    gsub(/::/, '/')
      .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
      .gsub(/([a-z\d])([A-Z])/, '\1_\2')
      .tr('-', '_')
      .downcase
      .gsub(/_id$/, '')
      .tr('_', ' ').capitalize
      .gsub(/\b([a-z])/) { Regexp.last_match[1].capitalize }
  end

  def humanize
    gsub(/_id$/, '').tr(/_/, ' ').capitalize
  end

  def underscore
    gsub(/::/, '/')
      .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
      .gsub(/([a-z\d])([A-Z])/, '\1_\2')
      .sub('-', '_')
      .downcase
  end

  def camelize(first_letter_in_uppercase = true)
    if first_letter_in_uppercase
      @str.gsub(%r{/(.?)}) { '::' + Regexp.last_match[1].upcase }
          .gsub(/(^|_)(.)/) { Regexp.last_match[2].upcase }
    else
      @str[0] + camelize[1..-1]
    end
  end
end
