require 'easy_translate'

module YamlTranslator
  module Adapters
    class GoogleTranslateAdapter < BaseAdapter
      # Translate for locale texts
      # @param [Hash] locale texts of translate target
      # @return [Hash] locale texts
      def translate(values, options = {})
        keys = []
        texts = []
        opts = default_options.merge(options)

        values.each_with_index do |(key, text)|
          keys << key # 0: a.b, 1: a.b.c
          texts << text # 0: a, 1: b
        end
        translated_texts = EasyTranslate.translate(texts, to: opts[:to], key: @options[:api_key])
        Hash[keys.zip(translated_texts || [])]
      end
    end
  end
end
