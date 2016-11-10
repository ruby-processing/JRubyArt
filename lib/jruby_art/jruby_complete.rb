# frozen_string_literal: true
class JRubyComplete
  def self.complete
    rcomplete = File.join(K9_ROOT, 'lib/ruby/jruby-complete.jar')
    return [rcomplete] if FileTest.exist?(rcomplete)
    warn "#{rcomplete} does not exist\nTry running `k9 --install`"
    exit
  end
end
