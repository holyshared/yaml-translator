module YamlTranslator
  module Adapters
    class NoopAdaptor
      def translate(values)
        values
      end
    end
  end
end
