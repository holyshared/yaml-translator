require "yaml-translator/adapters"

module YamlTranslator
  class Translator

    def initialize(adapter = Adapters::NoopAdaptor.new)
      @adapter = adapter
    end

    # Translate target
    #
    # @param [Locale] locale of translate target
    # @return [Locale] locale
    def translate(locale, options={})
      translated = @adapter.translate(locale.to_single_key_hash, options)
      Locale.new(translated.to_tree, options[:to])
    end
  end
end
