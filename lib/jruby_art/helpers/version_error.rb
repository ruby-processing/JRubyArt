
class JDKVersionError < StandardError
  def message
    'This version of JRubyArt requires JDK8 to work'
  end
end
