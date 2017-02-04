module YamlTranslator
  module Adapters
    class NoopAdaptor < BaseAdapter
      def translate(values, options={})
        values
      end
    end
  end
end
