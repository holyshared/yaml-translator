module YamlTranslator
  class Translator
    def initialize
      @path = KeyPath.new
    end

    def translate(values)
      rebuild(translate_tree(flatten(values)))
    end

    private

    def translate_tree(values)
      values
    end

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
