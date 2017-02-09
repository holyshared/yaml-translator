module YamlTranslator
  module Adapters
    class BaseAdapter
      attr_reader :name

      def initialize(options={})
        @name = adapter_name
        @options = options
      end

      def translate(values, options={})
        raise 'Translation processing is not implemented'
      end

      def default_options
        { to: :en }
      end

      private

      def adapter_name
        ptn = /[A-Z\s]*[^A-Z]*/
        class_name = self.class.name.split('::').last
        snake_case_s = class_name.gsub(/Adapter/, '').scan(ptn)
          .map { |v| v.empty? ? nil : v.downcase }
          .compact
          .join('_')
        snake_case_s.to_sym
      end
    end
  end
end
