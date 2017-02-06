module YamlTranslator
  module Structure
    module SingleKey
      # Covert to a flatten hash
      def to_single_key
        compact_of(self, KeyPath.new)
      end

      private

      # Covert to a flatten hash
      def compact_of(values={}, path=KeyPath.new)
        result = {}
        values.each_with_index do |(i, v)|
          path.move_to(i)
          if v.is_a?(Hash)
            result.merge!(compact_of(v, path))
          else
            result[path.to_s] = v
          end
          path.leave
        end
        result
      end
    end
  end
end
