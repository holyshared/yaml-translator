module YamlTranslator
  module Adapters
    class NoopAdapter < BaseAdapter
      def translate(values, options={})
        values
      end
    end
  end
end
