module YamlTranslator
  module Adapters
    class NoopAdaptor < BaseAdapter
      def translate(values)
        values
      end
    end
  end
end
