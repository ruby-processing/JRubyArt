# frozen_string_literal: false
require 'forwardable'
# reverting to StringExtra class, from a module with String refinements
class StringExtra
  extend Forwardable
  def_delegators(:@str, :upcase, :capitalize, :length, :downcase, :gsub)
  def initialize(str)
    @str = str
  end

  def titleize
    underscore
      .gsub(/_id$/, '').tr('_', ' ').capitalize
      .gsub(/\b([a-z])/) { Regexp.last_match[1].capitalize }
  end

  def humanize
    gsub(/_id$/, '').tr('_', ' ').capitalize
  end

  def camelize
    gsub(%r{/\/(.?)/}) { '::' + Regexp.last_match[1].upcase }
      .gsub(/(^|_)(.)/) { Regexp.last_match[2].upcase }
  end

  def underscore
    gsub(/::/, '/')
      .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
      .gsub(/([a-z\d])([A-Z])/, '\1_\2')
      .tr('-', '_')
      .downcase
  end
end
