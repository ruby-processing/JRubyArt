# frozen_string_literal: false
# String refinement for sketch creator
module StringExtra
  refine String do
    def titleize
      underscore
        .humanize
        .gsub(/\b([a-z])/) { Regexp.last_match[1].capitalize }
    end

    def humanize
      gsub(/_id$/, '').tr('_', ' ').capitalize
    end

    def camelize(first_letter_uppercase = true)
      return first + camelize[1..-1] unless first_letter_uppercase
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
end
