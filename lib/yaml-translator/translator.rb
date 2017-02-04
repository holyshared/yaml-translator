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
    # @return [Hash] translated hash
    def translate(values)
      rebuild(translate_tree(flatten(values)))
    end

    private

    # Translate target
    #
    # @param [Hash] values Hash of translate target
    # @return [Hash] translated hash
    def translate_tree(values)
      @adapter.translate(values)
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
          result[@path.to_s] ||= {}
          result[@path.to_s].merge!(translate_tree(v))
        else
          result[@path.to_s] = v
        end
        @path.leave
      end
      result
    end
  end
end
