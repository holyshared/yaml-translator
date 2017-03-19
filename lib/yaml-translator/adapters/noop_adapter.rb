module YamlTranslator
  module Adapters
    class NoopAdapter < BaseAdapter
      # Always return the text before translation
      # @param [Hash] locale texts of translate target
      # @return [Hash] locale texts
      def translate(values, options = {})
        values
      end
    end
  end
end
