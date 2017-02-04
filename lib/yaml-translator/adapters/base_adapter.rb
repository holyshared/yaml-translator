module YamlTranslator
  module Adapters
    class BaseAdapter
      def translate(values, options={})
        raise 'Translation processing is not implemented'
      end

      def default_options
        { to: :en }
      end
    end
  end
end
