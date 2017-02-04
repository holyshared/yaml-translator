require "yaml-translator/adapters"

module YamlTranslator
  class Translator
    def initialize(adapter = Adapters::NoopAdaptor.new)
      @path = KeyPath.new
      @adapter = adapter
    end

    # Translate target
    #
    # @param [Hash] values Hash of translate target
    # @return [TranslatedResult] translated result
    def translate(values, options={})
      TranslatedResult.new(rebuild(translate_tree(flatten(values), options)), options[:to])
    end

    # Translate target file
    #
    # @param [Hash] file YAML file of translate target
    # @return [TranslatedResult] translated result
    def translate_file(file, options={})
      yaml = YAML.load(File.open(file, &:read))
      translate(yaml)
    end

    private

    # Translate target
    #
    # @param [Hash] values Hash of translate target
    # @return [Hash] translated hash
    def translate_tree(values, options={})
      @adapter.translate(values, options)
    end

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

    # Covert to a flat hash
    # @param [Hash] values flatten target
    # @return [Hash]
    def flatten(values)
      result = {}
      values.each_with_index do |(i, v)|
        @path.move_to(i)
        if v.is_a?(Hash)
          result.merge!(flatten(v))
        else
          result[@path.to_s] = v
        end
        @path.leave
      end
      result
    end
  end
end
