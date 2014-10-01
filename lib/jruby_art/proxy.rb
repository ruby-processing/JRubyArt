module Processing
  # This module should be included into a class to enable it
  # to proxy messages between it and the processing instance.
  #
  module Proxy
    attr_accessor :processing_instance # internal processing instance.

    # Class should be instantiated with an instance of a processing
    # sketch.
    #
    def initialize(processing_instance)
      # Guard against invalid input.
      fail TypeError unless processing_instance.is_a? SimpleApp
      # Assign instance variable.
      @processing_instance = processing_instance
    end

    # This method proxies unknown methods to the internal processing
    # instance.
    #
    def method_missing(method, *args, &block)
      processing_instance.send(method, *args, &block)
    end
  end
end
