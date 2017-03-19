require 'yaml-translator/adapters/base_adapter'
require 'yaml-translator/adapters/noop_adapter'
require 'yaml-translator/adapters/google_translate_adapter'

module YamlTranslator
  module Adapters
    class << self
      def find_and_create(name, options = {})
        prefix = name.to_s.split('_').map(&:capitalize).join('')
        find_adapter_name = "#{prefix}Adapter"
        raise "adapter #{find_adapter_name} is not defined" unless class_exists?(find_adapter_name)
        const_get(find_adapter_name).new(options)
      end

      private

      def class_exists?(class_name)
        const_defined?(class_name) && const_get(class_name).is_a?(Class)
      end
    end
  end
end
