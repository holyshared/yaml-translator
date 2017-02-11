require "yaml-translator/adapters"

module YamlTranslator
  class Translator
    def initialize(adapter = Adapters::NoopAdapter.new)
      @adapter = adapter
    end

    def adapter_name
      @adapter.name
    end

    # Translate target
    #
    # @param [Hash] locale texts of translate target
    # @return [Hash] locale texts
    def translate(locale_texts, options={})
      @adapter.translate(locale_texts, options)
    end

    def string(s)
      StringContext.new(Locale.load(s), self)
    end

    def file(f)
      FileContext.new(Locale.load_file(f), self)
    end
  end
end
