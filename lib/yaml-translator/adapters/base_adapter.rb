module YamlTranslator
  module Adapters
    class BaseAdapter
      def translate(values)
        raise 'Translation processing is not implemented'
      end
    end
  end
end
