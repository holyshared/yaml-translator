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
      translated = @adapter.translate(locale.flatten_hash, options)
      Locale.new(rebuild(translated), options[:to])
    end

    private

    # Returning the flattened structure to the tree structure
    #
    # @param [Hash] values flatten Hash
    # @return [Hash] translated hash
    def rebuild(values)
      result = {}
      current = result
      values.each do |k, v|
        keys = k.split('.')
        last_key = keys.pop
        keys.each do |ks|
          current = if current.key?(ks)
                      current[ks]
                    else
                      current[ks] = {}
                      current[ks]
                    end
        end
        current[last_key] = v
        current = result
      end
      result
    end
  end
end
