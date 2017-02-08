require "yaml-translator/adapters"

module YamlTranslator
  class Translator

    def initialize(adapter = Adapters::NoopAdapter.new)
      @adapter = adapter
    end

    # Translate target
    #
    # @param [Locale] locale of translate target
    # @return [Locale] locale
    def translate(locale, options={})
      translated = @adapter.translate(locale.to_single_key_hash, options)
      translated_tree = translated.to_tree

      result = {}
      result[options[:to].to_s] = translated_tree[locale.lang]

      Locale.new(result, options[:to])
    end

    def string(s)
      StringContext.new(Locale.load(s), self)
    end

    def file(f)
      FileContext.new(Locale.load_file(f), self)
    end
  end
end
