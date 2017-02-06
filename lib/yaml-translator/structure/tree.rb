module YamlTranslator
  module Structure
    module Tree
      def to_tree
        tree_of(self)
      end

      private

      # Returning the flattened structure to the tree structure
      #
      # @param [Hash] values flatten Hash
      # @return [Hash] translated hash
      def tree_of(values)
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
end
